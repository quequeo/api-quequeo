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
    rescue_from ActionController::RoutingError, with: :route_not_found
    rescue_from StandardError, with: :internal_server_error
  end

  private

  def no_method_error(exception)
    render json: { 
      message: "An unexpected error occurred",
      error: exception.message
    }, status: :internal_server_error
  end

  def not_found(exception)
    render json: {
      message: "The requested resource could not be found",
      error: exception.message
    }, status: :not_found
  end

  def unprocessable_entity(exception)
    render json: {
      message: "The request was unacceptable",
      error: exception.message
    }, status: :unprocessable_entity
  end  

  def missing_parameters(exception)
    render json: {
      message: "The request is missing required parameters",
      error: exception.message
    }, status: :unprocessable_entity
  end

  def method_not_allowed(exception)
    render json: {
      message: "The requested method is not allowed",
      error: exception.message
    }, status: :method_not_allowed
  end

  def route_not_found
    render json: { message: "The requested route could not be found" }, status: :not_found
  end

  def internal_server_error(exception)
    render json: {
      message: "An unexpected error occurred",
      error: exception.message
    }, status: :internal_server_error
  end
end
