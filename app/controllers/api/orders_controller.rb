module Api
  class OrdersController < ApplicationController
    def index
      @orders = Order.today_ones
      render json: @orders, status: :ok
    end

    def create
      order = Order.create(order_params)
      return bad_request(order.errors) unless order.errors.blank?

      render json: order, status: :created
    end

    private

    def order_params
      params.require(:order)
            .permit(:tracking_id, :service_type, :shipping_cost, :total,
                    :notes, :payment_type, :client_name, :client_phone_number,
                    :state, variant_ids: [])
    end
  end
end
