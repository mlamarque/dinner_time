# frozen_string_literal: true

class Import::AllrecipesService
  def call
    import
  end

  private

  def import
    data = File.read(File.join(Rails.root, "recipes-en.json"))
    JSON.parse(data).each do |recipe_data|
      recipe_data = recipe_data.with_indifferent_access
      recipe = Recipe.find_or_initialize_by(name: recipe_data[:title])

      recipe.update(
        name: recipe_data[:title],
        cook_time: recipe_data[:cook_time],
        prep_time: recipe_data[:prep_time],
        rate: recipe_data[:ratings],
        tags: [Tag.find_or_initialize_by(name: recipe_data[:category])],
        author: recipe_data[:author],
        image: recipe_data[:image]
      )
      recipe.foods = fill_foods(recipe_data[:ingredients])
    end
  end

  def fill_foods(ingredients)
    ingredients.map do |ingredient|
      Food.find_or_create_by(name: ingredient)
    end
  end
end
