# frozen_string_literal: true

FactoryBot.define do
  factory :recipe do
    sequence(:name) { |n| "#{Faker::Food.dish}-#{n}" }
    author { Faker::Name.name }
    difficulty { rand(5) }
    prep_time { rand(100) }
    cook_time { rand(100) }
    rate { rand(5) }
    image { "MyString" }
    after(:create) do |recipe|
      create_list(:ingredient, 5, recipe: recipe)
      recipe.reload
    end
  end
end
