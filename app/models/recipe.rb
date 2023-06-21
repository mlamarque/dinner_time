# frozen_string_literal: true

class Recipe < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  has_many :foods, through: :ingredients
  has_and_belongs_to_many :tags

  validates :name, presence: true, uniqueness: true
  validates :prep_time, presence: true
  validates :cook_time, presence: true
  validates :author, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_food,
                  associated_against: { foods: :name },
                  using: { tsearch: { prefix: true, any_word: false } }
end
