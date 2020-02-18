class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from AASM::InvalidTransition, with: :invalid_transition

  def record_not_found
    render json: { error: 'record not found' }, status: :not_found
  end

  def bad_request(err)
    render json: { error: err }, status: :bad_request
  end

  def unprocessable_entity(err)
    render json: { error: err }, status: :unprocessable_entity
  end
end
