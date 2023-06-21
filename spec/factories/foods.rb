# frozen_string_literal: true

FactoryBot.define do
  factory :food do
    sequence(:name) { |n| "#{Faker::Food.ingredient}-#{n}" }
  end
end
