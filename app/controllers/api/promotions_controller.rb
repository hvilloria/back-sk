module Api
  class PromotionsController < ApplicationController
    # before_action :authenticate_user!

    def index
      promotions = Promotion.active_ones
      render json: promotions, status: :ok
    end

    def show
      render json: promotion, status: :ok
    end

    def create
      promotion = Promotion.create(promotion_permitted_params)
      return bad_request(promotion.errors) unless promotion.errors.blank?

      render json: promotion, status: :created 
    end

    def update
      return bad_request(promotion.errors) unless promotion.update(promotion_permitted_params)

      render json: promotion, status: :ok
    end

    def destroy
      promotion.destroy

      head :ok
    end

    private

    def promotion
      Promotion.find(params[:id])
    end

    def promotion_permitted_params
      params.require(:promotion)
            .permit(:status, :from_date, :to_date, :kind, :base_price,
                    :percentage, frequency: [], p_groups_attributes: [:id, :kind, :_destroy, variant_ids:[]])
    end
  end
end
