class Api::V1::AuthController < ApplicationController
  def instance
    render json: { message: "Wellio API is running on EC2" }, status: :ok
  end
end
