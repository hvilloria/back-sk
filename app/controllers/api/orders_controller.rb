module Api
  class OrdersController < ApplicationController
    before_action :authenticate_user!
    def index
      @orders = Order.today_ones
      render json: @orders, status: :ok
    end

    def create
      order = Order.create(order_params)
      return bad_request(order.errors) unless order.errors.blank?

      render json: order, status: :created
    end

    def modify_status
      order = Order.find(params[:id])
      order.send(params[:status])
      return unprocessable_entity(order.errors) unless order.save

      render json: order, status: :ok
    end

    def update
      order = Order.find(params[:id])
      order.assign_attributes(update_params)
      return bad_request(order.errors) unless order.save

      render json: order, status: :ok
    end

    private

    def order_params
      params.require(:order)
            .permit(:tracking_id, :service_type, :shipping_cost, :total, :address,
                    :notes, :payment_type, :client_name, :client_phone_number,
                    :state, variant_ids: [])
    end

    def update_params
      params.require(:order)
            .permit(:service_type, :shipping_cost, :total, :notes, :state)
    end
  end
end
