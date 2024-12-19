class Project < ApplicationRecord
  belongs_to :user

  has_one_attached :logo, dependent: :destroy
  has_many_attached :images

  def build_json
    {
      id: id,
      title: title,
      description: description,
      logo_url: logo_url
    }
  end

  private

  def logo_url
    return nil unless logo.attached?
    
    Rails.application.routes.url_helpers.rails_blob_url(logo, host: Rails.application.routes.default_url_options[:host])
  end
end
