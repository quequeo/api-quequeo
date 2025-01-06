class Resume < ApplicationRecord
  belongs_to :user
  has_many :sections, dependent: :destroy

  accepts_nested_attributes_for :sections, allow_destroy: true

  STYLES = { basic: 'basic', modern: 'modern', professional: 'professional' }.freeze

  validates :title, presence: true, length: { maximum: 100 }
  validates :style, presence: true, inclusion: { in: STYLES.keys.map(&:to_s) }

  STYLES.each_key do |key|
    define_method("#{key}?") do
      style == STYLES[key]
    end
  end
end
