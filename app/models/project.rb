class Project < ApplicationRecord
  belongs_to :user

  has_one_attached :logo
  has_many_attached :images

  def build_json
    {
      id: id,
      title: title,
      description: description,
      logo_url: logo.attached? ? Rails.application.routes.url_helpers.url_for(logo) : nil,
      images_urls: images.attached? ? images.map { |image| Rails.application.routes.url_helpers.url_for(image) } : []
    }
  end
end
