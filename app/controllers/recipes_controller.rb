# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show]

  def index
    recipes = if params[:search].blank?
      Recipe.all
    elsif params[:type_of_search] == "any"
      Recipe.search_any_food(clean_search_keywords)
    else
      Recipe.search_all_food(clean_search_keywords)
    end
    @pagy, @recipes = pagy(recipes.includes(:foods))
  end

  def show; end

  private

  def clean_search_keywords
    return if params[:search].blank?

    params[:search].split(/[,?.\s]/).uniq.reject(&:blank?)
  end

  def set_recipe
    @recipe = Recipe.find_by_id(params[:id])
  end
end
