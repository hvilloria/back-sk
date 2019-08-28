module Api
  class CategoriesController < ApplicationController
    def index
      @categories = Category.active_ones
      render json: @categories, status: :ok
    end
  end
end
