module Api
  class SellsController < ApplicationController
    before_action :authenticate_user!
    def index
      sells = {
        online: Order.online.today_ones.pluck(:total).reduce(:+),
        cash: Order.cash.today_ones.pluck(:total).reduce(:+)
      }
      render json: sells, status: :ok
    end
  end
end
