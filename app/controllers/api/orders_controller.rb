module Api
  class OrdersController < ApplicationController
    def create
      order = Order.create(order_params)
      return bad_request(order.errors) unless order.errors.blank?

      render json: order, status: :created
    end

    private

    def order_params
      params.require(:order)
            .permit(:tracking_id,
                    :client_id,
                    :service_type,
                    :shipping_cost,
                    :total,
                    :notes,
                    product_ids: [])
    end
  end
end
