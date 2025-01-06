class Api::Resume::V1::UsersController < Api::Resume::ApplicationController
  after_action :verify_authorized

  # GET /users/:id
  def show
    authorize current_user
    render json: current_user, serializer: UserSerializer
  end

  # PATCH/PUT /users/:id
  def update
    authorize current_user
    if current_user.update(user_params)
      render json: current_user
    else
      render json: current_user.errors, status: :unprocessable_entity
    end
  end

  # PATCH /users/:id/avatar
  def avatar
    authorize current_user
    if current_user.update(avatar: params[:avatar])
      render json: current_user
    else
      render json: current_user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:project).permit(:email, :avatar)
  end
end
