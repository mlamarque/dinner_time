# frozen_string_literal: true

require "rails_helper"

RSpec.describe Import::AllrecipesService, type: :model do
  let!(:service) { Import::AllrecipesService.new }

  describe "#call" do
    it "should call import method" do
      expect_any_instance_of(Import::AllrecipesService).to receive(:import)
      service.call
    end
  end

  describe "#call" do
    before :each do
      allow(File).to receive(:read).and_return('[{"title":"Golden Sweet Cornbread","cook_time":25,"prep_time":10,"ingredients":["1 cup all-purpose flour","1 cup yellow cornmeal","⅔ cup white sugar","1 teaspoon salt","3 ½ teaspoons baking powder","1 egg","1 cup milk","⅓ cup vegetable oil"],"ratings":4.74,"cuisine":"","category":"Cornbread","author":"bluegirl","image":"https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F43%2F2021%2F10%2F26%2Fcornbread-1.jpg"},{"title":"Monkey Bread I","cook_time":35,"prep_time":15,"ingredients":["3 (12 ounce) packages refrigerated biscuit dough","1 cup white sugar","2 teaspoons ground cinnamon","½ cup margarine","1 cup packed brown sugar","½ cup chopped walnuts","½ cup raisins"],"ratings":4.74,"cuisine":"","category":"Monkey Bread","author":"deleteduser","image":"https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F43%2F2018%2F11%2F546316.jpg"}]')
    end
    it "should create recipes" do
      expect do
        service.call
      end
        .to change { Recipe.count }
        .by(2)
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
      allow(File).to receive(:read).and_return('[{"title":"Golden Sweet Cornbread","cook_time":25,"prep_time":10,"ingredients":["1 cup all-purpose flour","1 cup yellow cornmeal","⅔ cup white sugar","1 teaspoon salt","3 ½ teaspoons baking powder","1 egg","1 cup milk","⅓ cup vegetable oil"],"ratings":4.74,"cuisine":"","category":"Cornbread","author":"bluegirl","image":"https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F43%2F2021%2F10%2F26%2Fcornbread-1.jpg"},{"title":"Monkey Bread I","cook_time":35,"prep_time":15,"ingredients":["3 (12 ounce) packages refrigerated biscuit dough","1 cup white sugar","2 teaspoons ground cinnamon","½ cup margarine","1 cup packed brown sugar","½ cup chopped walnuts","½ cup raisins"],"ratings":4.74,"cuisine":"","category":"Monkey Bread","author":"deleteduser","image":"https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F43%2F2018%2F11%2F546316.jpg"}]')
    end

    it "should fill_foods" do
      expect(Food).to receive(:find_or_create_by)
        .with(instance_of(Hash))
        .exactly(15)
        .times.and_call_original
      service.call
    end

    it "should fill_foods" do
      expect do
        service.call
      end
        .to change { Food.count }
        .by(15)
    end
  end
end
