# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show]

  def index
    recipes = if params[:search].blank?
      Recipe.all.includes(:foods)
    else
      Recipe.search_by_food(clean_search_keywords).includes(:foods)
    end
    @pagy, @recipes = pagy(recipes)
  end

  def show; end

  private

  def clean_search_keywords
    return if params[:search].blank?

    params[:search].split(/[,?.\s]/).uniq.reject(&:blank?)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
