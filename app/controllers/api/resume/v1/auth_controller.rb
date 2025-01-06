class Api::Resume::V1::AuthController < Api::Resume::ApplicationController
  before_action :validate_auth_params, only: [:register, :login]

  # POST /register
  def register
    user = User.new(auth_params)
    if user.save
      token = encode_token({ user_id: user.id })
      render json: { user: user, token: token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # POST /login
  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = encode_token({ user_id: user.id })
      render json: { 
        user: UserSerializer.new(user).as_json,
        token: token 
      }, status: :ok
    else
      render json: { errors: [ "Invalid email or password" ] }, status: :unauthorized
    end
  end

  private

  def auth_params
    params.permit(:email, :password, :password_confirmation)
  end

  def encode_token(payload)
    JWT.encode(payload, SECRET_KEY)
  end

  def validate_auth_params
    if params[:email].blank?
      render json: { errors: [ "Email is required" ] }, status: :unprocessable_entity
    end

    if params[:password].blank?
      render json: { errors: [ "Password is required" ] }, status: :unprocessable_entity
    end
  end
end
