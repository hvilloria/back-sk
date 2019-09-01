module Api
  class CategoriesController < ApplicationController
    def index
      @categories = Category.active_ones
      render json: @categories, status: :ok
    end

    def create
      category = Category.new(category_permitted_params)
      return bad_request(category.errors) unless category.save

      render json: category, status: :created
    end

    def update
      category = Category.find(params[:id])
      category.assign_attributes(category_permitted_params)
      return bad_request(category.errors) unless category.save

      render json: category, status: :ok
    end

    private

    def category_permitted_params
      params.require(:category).permit(:name, :status)
    end
  end
end
