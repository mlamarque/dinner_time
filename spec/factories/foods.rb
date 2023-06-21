FactoryBot.define do
  factory :food do
    sequence(:name) { |n| "#{Faker::Food.ingredient}-#{n}" }
  end
end
