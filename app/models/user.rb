class User < ApplicationRecord
  has_secure_password

  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles

  has_many :projects
  validates :email, presence: true, uniqueness: true

  has_one_attached :avatar

  def has_role?(role_name)
    roles.exists?(name: role_name)
  end

  private

  def avatar_url
    return nil unless avatar.attached?
    
    Rails.application.routes.url_helpers.rails_blob_url(avatar, host: Rails.application.routes.default_url_options[:host])
  end
end
