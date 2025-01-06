class ApplicationController < ActionController::API
  WEB_QUEQUEO_SECRET_KEY = ENV["WEB_QUEQUEO_SECRET_KEY"]

  def validate_web_quequeo_secret_key
    secret_key = request.headers["X-Secret-Key"]
    render json: { message: "Invalid secret key" }, status: :unauthorized unless secret_key == WEB_QUEQUEO_SECRET_KEY
  end
end
