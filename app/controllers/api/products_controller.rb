module Api
  class ProductsController < ApplicationController
    def update
      product = Product.find(params[:id])
      product.assign_attributes(product_permitted_params)
      return bad_request(product.errors) unless product.save

      render json: product, status: :ok
    end

    private

    def product_permitted_params
      params.require(:product).permit(:name, :price, :status)
    end
  end
end
