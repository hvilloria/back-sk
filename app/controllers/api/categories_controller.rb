module Api
  class CategoriesController < ApplicationController
    before_action :authenticate_user!, except: :index
    def index
      categories = Category.includes(products: :variants)
                           .active_ones
                           .references(:products)
      render json: categories, status: :ok
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
