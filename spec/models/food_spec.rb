# frozen_string_literal: true

require "rails_helper"

RSpec.describe Food, type: :model do
  describe "Attributes: " do
    it {
      is_expected
        .to have_db_column(:name)
        .of_type(:string)
        .with_options(null: false)
    }
  end

  describe "Associations: " do
    it {
      is_expected
        .to have_many(:ingredients)
    }
  end

  describe "Validations: " do
    it { is_expected.to validate_presence_of(:name) }

  end
end
