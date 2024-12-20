class Api::V1::Me::UsersController < ApplicationController
  before_action :set_user, only: %i[ show update avatar ]
  # GET /users/1
  def show
    render json: @user, serializer: UserSerializer
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def avatar
    if @user.update(avatar: params[:avatar])
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user ||= User.find_by(email: 'admin@quequeo.com')
  end

  def user_params
    params.require(:project).permit(:email, :avatar)
  end
end
