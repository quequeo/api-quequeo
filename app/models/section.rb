class Section < ApplicationRecord
  belongs_to :resume

  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 1000 }
end
