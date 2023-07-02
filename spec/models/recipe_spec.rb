# frozen_string_literal: true

require "rails_helper"

RSpec.describe Recipe, type: :model do
  describe "Attributes: " do
    it {
      is_expected
        .to have_db_column(:name)
        .of_type(:string)
        .with_options(null: false)
    }
    it {
      is_expected
        .to have_db_column(:difficulty)
        .of_type(:integer)
        .with_options(default: 0)
    }
    it {
      is_expected
        .to have_db_column(:prep_time)
        .of_type(:integer)
        .with_options(null: false)
    }
    it {
      is_expected
        .to have_db_column(:cook_time)
        .of_type(:integer)
        .with_options(null: false)
    }
    it {
      is_expected
        .to have_db_column(:rate)
        .of_type(:float)
    }
    it {
      is_expected
        .to have_db_column(:author)
        .of_type(:string)
        .with_options(null: false)
    }
    it {
      is_expected
        .to have_db_column(:image)
        .of_type(:string)
        .with_options(null: false)
    }
  end

  describe "Associations: " do
    it {
      is_expected
        .to have_many(:ingredients)
    }
    it {
      is_expected
        .to have_many(:foods).through(:ingredients)
    }
    it {
      is_expected
        .to have_and_belong_to_many(:tags)
    }
  end

  describe "Validations: " do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:prep_time) }
    it { is_expected.to validate_presence_of(:cook_time) }
    it { is_expected.to validate_presence_of(:author) }
  end

  describe "Callbacks: " do
    it "is called set_slug on create" do
      recipe = FactoryBot.create(:recipe)
      expect(recipe.slug).to eq(recipe.name.to_s.parameterize)
    end

    it "is called set_slug on update" do
      recipe = FactoryBot.create(:recipe)
      recipe.update(name: "lorem")
      expect(recipe.slug).to eq(recipe.name.to_s.parameterize)
    end
  end

  describe ".pg_search_scope" do
    let!(:recipe_a) { FactoryBot.create(:recipe) }
    let!(:recipe_b) { FactoryBot.create(:recipe) }

    describe "search_all_food" do
      context "with empty query" do
        it "return empty array" do
          expect(Recipe.search_all_food("")).to be_empty
        end
      end
      context "with 1 ingredient" do
        it "return results" do
          expect(Recipe.search_all_food(recipe_a.foods.first.name)).to contain_exactly(recipe_a)
        end
      end
      context "with many ingredients" do
        it "return results" do
          salt = FactoryBot.create(:food, name: "salt")
          pepper = FactoryBot.create(:food, name: "pepper")
          suggar = FactoryBot.create(:food, name: "suggar")
          recipe_a = FactoryBot.create(:recipe, ingredients:
            [
              FactoryBot.create(:ingredient, food: salt),
              FactoryBot.create(:ingredient, food: pepper)
            ])
          recipe_b = FactoryBot.create(:recipe, ingredients:
            [
              FactoryBot.create(:ingredient, food: salt),
              FactoryBot.create(:ingredient, food: pepper),
              FactoryBot.create(:ingredient, food: suggar)
            ])
          expect(Recipe.search_all_food("salt pepper"))
            .to contain_exactly(recipe_a, recipe_b)
        end
      end
      context "with some part of ingredient name" do
        it "return results" do
          expect(Recipe.search_all_food(recipe_a.foods.first.name[0..2]))
            .to contain_exactly(recipe_a)
        end
      end
    end

    describe "search_any_food" do
      context "with empty query" do
        it "return empty array" do
          expect(Recipe.search_any_food("")).to be_empty
        end
      end
      context "with 1 ingredient" do
        it "return results" do
          expect(Recipe.search_any_food(recipe_a.foods.first.name)).to contain_exactly(recipe_a)
        end
      end
      context "with many ingredients" do
        it "return results" do
          salt = FactoryBot.create(:food, name: "salt")
          pepper = FactoryBot.create(:food, name: "pepper")
          suggar = FactoryBot.create(:food, name: "suggar")
          recipe_a = FactoryBot.create(:recipe, ingredients:
            [
              FactoryBot.create(:ingredient, food: salt),
            ])
          recipe_b = FactoryBot.create(:recipe, ingredients:
            [
              FactoryBot.create(:ingredient, food: salt),
              FactoryBot.create(:ingredient, food: pepper),
              FactoryBot.create(:ingredient, food: suggar)
            ])
          expect(Recipe.search_any_food("salt pepper"))
            .to contain_exactly(recipe_a, recipe_b)
        end
      end
      context "with some part of ingredient name" do
        it "return results" do
          expect(Recipe.search_any_food(recipe_a.foods.first.name[0..2]))
            .to contain_exactly(recipe_a)
        end
      end
    end
  end

  describe "to_param" do
    let!(:recipe_a) { FactoryBot.create(:recipe) }

    it "return parame identifier" do
      expect(recipe_a.to_param).to eq("#{recipe_a.id}-#{recipe_a.slug}")
    end
  end
end
