class User < ApplicationRecord
  has_secure_password

  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles
  has_many :resumes, dependent: :destroy
  has_one_attached :avatar
  
  validates :email, presence: true, uniqueness: true, format: { 
    with: URI::MailTo::EMAIL_REGEXP, 
    message: "must be a valid email address" 
  }

  def has_role?(role_name)
    roles.exists?(name: role_name)
  end

  def admin?
    has_role?('admin')
  end  

  private

  def avatar_url
    return nil unless avatar.attached?
    
    Rails.application.routes.url_helpers.rails_blob_url(
      avatar, 
      host: Rails.application.routes.default_url_options[:host]
    )
  end
end
