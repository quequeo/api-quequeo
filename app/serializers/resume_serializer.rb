class ResumeSerializer < ActiveModel::Serializer
  attributes :id, :title, :style, :created_at, :updated_at

  belongs_to :user

  has_many :sections, serializer: SectionSerializer
end
