# frozen_string_literal: true

require "rails_helper"

RSpec.describe Tag, type: :model do
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
        .to have_and_belong_to_many(:recipes)
    }
  end
end
