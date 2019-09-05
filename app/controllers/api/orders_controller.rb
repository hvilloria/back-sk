module Api
  class OrdersController < ApplicationController
    def index
      @orders = Order.today_ones
      render json: @orders, status: :ok
    end
  end
end
