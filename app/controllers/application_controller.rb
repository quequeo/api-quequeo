class ApplicationController < ActionController::API
  SECRET_KEY = Rails.application.credentials.secret_key_base

  def decode_token
    auth_header = request.headers['Authorization']
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256')[0]
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def current_user
    decoded_token = decode_token
    if decoded_token
      user_id = decoded_token['user_id']
      @current_user = User.find_by(id: user_id)
    end
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless current_user
  end
end