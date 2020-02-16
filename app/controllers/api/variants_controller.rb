module Api
  class VariantsController < ApplicationController
    before_action :authenticate_user!

    def update
      variant = Variant.find(params[:id])
      variant.assign_attributes(variant_permitted_params)
      return bad_request(variant.errors) unless variant.save

      render json: variant, status: :ok
    end

    private

    def variant_permitted_params
      params.require(:variant).permit(:name, :price, :status, :description)
    end
  end
end
