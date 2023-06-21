# frozen_string_literal: true

FactoryBot.define do
  factory :ingredient do
    food
    recipe
    quantity { 1 }
  end
end
