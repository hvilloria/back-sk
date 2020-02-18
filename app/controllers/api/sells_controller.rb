module Api
  class SellsController < ApplicationController
    before_action :authenticate_user!
    def index
      sells = {
        tk: Order.take_aways.pluck(:total).reduce(:+),
        dl: Order.deliverys.pluck(:total).reduce(:+)
      }
      render json: sells, status: :ok
    end
  end
end
