class Project < ApplicationRecord
  belongs_to :user

  has_one_attached :logo, dependent: :destroy
  has_many_attached :images

  validates :title, presence: true
  validates :description, presence: true

  private

  def logo_url
    return nil unless logo.attached?
    
    Rails.application.routes.url_helpers.rails_blob_url(logo, host: Rails.application.routes.default_url_options[:host])
  end
end
