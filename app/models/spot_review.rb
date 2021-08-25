class SpotReview < ApplicationRecord
  belongs_to :spot, counter_cache: true
  belongs_to :user

  attr_accessor :id_spot, :id_user

  validate :check_spot_review_max, on: :create

  def count_of_spot_review
    @spot = Spot.find_by(id: id_spot)

    @spot.spot_reviews.select { |spot_review| spot_review.user_id == id_user }.count
  end

  def check_spot_review_max
    errors.add(:user_id, 'それぞれのユーザーがそれぞれのスポートにレービューを書く数が３回だけです') if count_of_spot_review > 2
  end
end
