module Errorable
  extend ActiveSupport::Concern

  included do
    rescue_from NoMethodError, with: :no_method_error
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
    rescue_from ActionController::ParameterMissing, with: :missing_parameters
    rescue_from ActionController::RoutingError, with: :not_found
    rescue_from ActionController::UnknownFormat, with: :not_found
    rescue_from ActionController::UnknownHttpMethod, with: :method_not_allowed
    rescue_from ActionController::InvalidAuthenticityToken, with: :unprocessable_entity
  end

  private

  def no_method_error
    render json: { 
      message: "An unexpected error occured",
      error: error.message
    }, status: :internal_server_error
  end

  def not_found
    render json: {
      message: "The requested resource could not be found",
      error: error.message
    }, status: :not_found
  end

  def unprocessable_entity
    render json: {
      message: "The request was unacceptable",
      error: error.message
    }, status: :unprocessable_entity
  end

  def missing_parameters
    render json: {
      message: "The request is missing required parameters",
      error: error.message
    }, status: :unprocessable_entity
  end

  def method_not_allowed
    render json: {
      message: "The requested method is not allowed",
      error: error.message
    }, status: :method_not_allowed
  end
end
