# frozen_string_literal: true

require "benchmark"

class Import::AllrecipesService
  NUM_THREADS = 4

  def call
    queue = Queue.new

    data = File.read(File.join(Rails.root, "recipes-en.json"))
    JSON.parse(data).each do |recipe_data|
      queue << recipe_data
    end
    threads = []
    NUM_THREADS.times do
      threads << Thread.new { process_recipes(queue) }
    end

    threads.each(&:join)
  end

  private

  def process_recipes(queue)
    until queue.empty?
      recipe_data = queue.pop(true) rescue nil
      next if recipe_data.nil?

      recipe = Recipe.find_or_initialize_by(name: recipe_data["title"])
      recipe.assign_attributes(
        cook_time: recipe_data["cook_time"],
        prep_time: recipe_data["prep_time"],
        rate: recipe_data["ratings"],
        tags: [Tag.find_or_create_by(name: recipe_data["category"])],
        author: recipe_data["author"],
        image: recipe_data["image"]
      )
      recipe.foods = fill_foods(recipe_data["ingredients"])
      recipe.save
    end
  end

  def fill_foods(ingredients)
    ingredients.uniq.map do |ingredient|
      Food.find_or_create_by(name: ingredient)
    end
  end
end

# Benchmark
# data 600
# v1 -> 18.890969
# v2 sans with_indifferent_access + multi-threading -> 15.042988

# data 10k
# v1 avec with_indifferent_access + monothread      -> 329.041571  35.270902 364.312473 (611.360750)
# v2 sans with_indifferent_access + 4 multi-threading -> 270.877207  51.402231 322.279438 (414.047046)
