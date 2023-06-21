FactoryBot.define do
  factory :ingredient do
    food
    recipe
    quantity { 1 }
  end
end
