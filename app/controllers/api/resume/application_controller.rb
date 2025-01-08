class Api::Resume::ApplicationController < ActionController::API
  include Pundit::Authorization
  include Errorable

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  SECRET_KEY = Rails.application.credentials.secret_key_base

  private

  def user_not_authorized
    Rails.logger.warn("Unauthorized access attempt by User ID: #{current_user&.id}")
    render json: { message: 'You are not authorized to perform this action' }, status: :unauthorized
  end

  def decode_token
    token = extract_token
    return unless token

    begin
      JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256').first
    rescue JWT::DecodeError => e
      Rails.logger.warn("JWT Decode Error: #{e.message}")
      nil
    end
  end

  def extract_token
    auth_header = request.headers['Authorization']
    return unless auth_header&.start_with?('Bearer ')

    auth_header.split(" ")[1]
  end

  def current_user
    return @current_user if defined?(@current_user)
  
    begin
      payload = decode_token
      return unless payload
  
      user_id = payload['user_id']
      @current_user = User.find_by!(id: user_id)
    end
  end
end
