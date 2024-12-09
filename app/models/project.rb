class Project < ApplicationRecord
  belongs_to :user

  has_one_attached :logo
  has_many_attached :images
end
