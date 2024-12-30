class Api::Web::AboutMeController < ApplicationController
  before_action :validate_web_quequeo_secret_key

  def content
    render json: Web::AboutMeService.call, status: :ok
  end
end
