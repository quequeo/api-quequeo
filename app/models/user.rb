class User < ApplicationRecord
  has_secure_password

  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles

  has_many :projects
  validates :email, presence: true, uniqueness: true

  def has_role?(role_name)
    roles.exists?(name: role_name)
  end
end
