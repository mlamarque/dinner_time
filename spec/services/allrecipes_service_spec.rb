# frozen_string_literal: true

require "rails_helper"

RSpec.describe Import::AllrecipesService, type: :model do
  let!(:service) { Import::AllrecipesService.new }

  describe "#call" do
    before :each do
      allow(File).to receive(:read).and_return(some_recipes_data)
    end
    it "should create recipes" do
      service.call
      expect(Recipe.count).to eq 2
    end

    it "should call process_recipes in every thread" do
      expect_any_instance_of(Import::AllrecipesService).to receive(:process_recipes)
        .exactly(Import::AllrecipesService::NUM_THREADS).times
      service.call
    end

    it "should assign tag" do
      service.call
      expect(Recipe.last.tags).to_not be_empty
    end

    it "should fill_foods" do
      expect_any_instance_of(Import::AllrecipesService).to receive(:fill_foods)
        .with(instance_of(Array))
        .twice
        .and_call_original
      service.call
    end
  end

  describe "#fill_foods" do
    before :each do
      allow(File).to receive(:read).and_return(some_recipes_data)
    end

    it "should fill_foods" do
      expect(Food).to receive(:find_or_create_by)
        .with(instance_of(Hash))
        .exactly(6)
        .times.and_call_original
      service.call
    end

    it "should fill_foods" do
      expect do
        service.call
      end
        .to change { Food.count }
        .by(6)
    end
  end
end
