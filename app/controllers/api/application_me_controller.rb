class Api::ApplicationMeController < ApplicationController
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def current_user
    @user ||= User.find_by(email: 'admin@quequeo.com')
  end

  def user_not_authorized
    render json: { message: "You are not authorized to perform this action" }, status: :unauthorized
  end
end
