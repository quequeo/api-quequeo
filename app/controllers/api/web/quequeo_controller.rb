class Api::Web::QuequeoController < ApplicationController
  before_action :validate_web_quequeo_secret_key

  def content
    render json: Web::QuequeoService.call, status: :ok
  end
end
