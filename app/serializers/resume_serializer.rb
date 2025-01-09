class ResumeSerializer < ActiveModel::Serializer
  attributes :id, :title, :style, :created_at, :updated_at

  belongs_to :user

  has_many :personal_informations
  has_many :work_experiences
end
