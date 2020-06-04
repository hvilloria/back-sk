module Api
  class ProductsController < ApplicationController
    before_action :authenticate_user!
    def update
      product = Product.find(params[:id])
      product.assign_attributes(product_permitted_params)
      return bad_request(product.errors) unless product.save

      render json: product, status: :ok
    end

    def create
      product = Product.new(product_permitted_params)
      return bad_request(product.errors) unless product.save

      render json: product, status: :created
    end

    def destroy
      product = Product.find(params[:id])
      product.destroy
      head :ok
    end

    private

    def product_permitted_params
      params.require(:product)
            .permit(:name, :status, :category_id, :description,
                    variants_attributes: %i[id base name price status])
    end
  end
end
