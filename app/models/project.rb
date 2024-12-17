class Project < ApplicationRecord
  belongs_to :user

  has_one_attached :logo, dependent: :destroy

  def build_json
    {
      id: id,
      title: title,
      description: description,
      logo_url: logo.attached? ? Rails.application.routes.url_helpers.rails_blob_url(logo, host: Rails.application.routes.default_url_options[:host]) : nil
    }
  end
end
