class Resume < ApplicationRecord
  belongs_to :user
  has_many :personal_informations, dependent: :destroy
  has_many :work_experiences, dependent: :destroy

  accepts_nested_attributes_for :personal_informations, allow_destroy: true
  accepts_nested_attributes_for :work_experiences, allow_destroy: true

  STYLES = { 
    simple: 'simple', 
    modern: 'modern', 
    expert: 'expert',
    creative: 'creative',
    vintage: 'vintage',
    developer: 'developer',
    executive: 'executive'
   }.freeze

  validates :title, presence: true, length: { maximum: 100 }
  validates :style, presence: true, inclusion: { in: STYLES.keys.map(&:to_s) }

  STYLES.each_key do |key|
    define_method("#{key}?") do
      style == STYLES[key]
    end
  end
end
