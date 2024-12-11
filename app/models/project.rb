class Project < ApplicationRecord
  belongs_to :user

  has_one_attached :logo
  has_many_attached :images

  def build_json
    {
      id: id,
      title: title,
      description: description,
      logo_url: logo.attached? ? Rails.application.routes.url_helpers.rails_blob_url(logo, host: Rails.application.routes.default_url_options[:host]) : nil,
      images: images.map { |img| Rails.application.routes.url_helpers.rails_blob_url(img, host: Rails.application.routes.default_url_options[:host]) }
    }
  end
end
