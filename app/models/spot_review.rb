class SpotReview < ApplicationRecord
  belongs_to :spot, counter_cache: true
  belongs_to :user

  attr_accessor :current_user

  validate :check_spot_review_max, on: :create

  def count_of_spot_review
    current_user.spot_reviews.where(spot_id: spot_id).size
  end

  def check_spot_review_max
    errors.add(:user_id, 'それぞれのユーザーがそれぞれのスポートにレービューを書く数が３回だけです') if count_of_spot_review > 2
  end
end
