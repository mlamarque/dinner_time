# frozen_string_literal: true

class Ingredient < ApplicationRecord
  belongs_to :food
  belongs_to :recipe

  validates :food, uniqueness: { scope: :recipe_id }
end
