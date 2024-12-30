class Api::Web::WorkExperienceController < ApplicationController
  before_action :validate_web_quequeo_secret_key

  def content
    render json: Web::WorkExperienceService.call, status: :ok
  end
end
