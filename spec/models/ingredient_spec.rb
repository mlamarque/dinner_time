# frozen_string_literal: true

require "rails_helper"

RSpec.describe Ingredient, type: :model do
  describe "Attributes: " do
    it {
      is_expected
        .to have_db_column(:quantity)
        .of_type(:string)
    }
    it {
      is_expected
        .to have_db_column(:food_id)
        .of_type(:uuid)
        .with_options(null: false)
    }
    it {
      is_expected
        .to have_db_column(:recipe_id)
        .of_type(:integer)
        .with_options(null: false)
    }
  end

  describe "Associations: " do
    it {
      is_expected
        .to belong_to(:food)
    }
    it {
      is_expected
        .to belong_to(:recipe)
    }
  end

  describe "Validations: " do
    subject { FactoryBot.build(:ingredient) }
    it { is_expected.to validate_uniqueness_of(:food).scoped_to(:recipe_id) }
  end
end
