class Spot < ApplicationRecord
  belongs_to :prefecture
  has_one :spot_tag, dependent: :destroy
  has_one :tag, through: :spot_tag
  has_many :spot_reviews, -> { order(posted_at: :desc) }, dependent: :destroy, inverse_of: :spot
  has_many :spot_schedules, dependent: :destroy
end
