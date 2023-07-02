# frozen_string_literal: true

require "rails_helper"

RSpec.describe RecipesController do
  describe "#index" do
    it "should render index" do
      get :index
      expect(response).to render_template(:index)
    end

    it "should render index with search parameters" do
      get :index, params: { search: "lorem" }
      expect(response).to render_template(:index)
    end

    it "should call search_any_food  with search parameter is present" do
      expect(Recipe).to receive(:search_any_food).and_call_original
      get :index, params: { search: "lorem", type_of_search: "any" }
    end

    it "should call search_all_food  with search parameter is present" do
      expect(Recipe).to receive(:search_all_food).and_call_original
      get :index, params: { search: "lorem" }
    end
  end

  describe "#show" do
    it "should display the recipe" do
      recipe = FactoryBot.create(:recipe)
      get :show, params: { id: recipe.id }
      expect(response).to render_template(:show)
    end
  end

  describe "#clean_search_keywords" do
    it "should clean search keywords" do
      expect(controller).to receive(:clean_search_keywords)
      get :index, params: { search: "lorem" }
    end
  end
end
