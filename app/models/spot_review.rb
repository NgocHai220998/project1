class SpotReview < ApplicationRecord
  belongs_to :spot, counter_cache: true
  belongs_to :user

  class << self
    def count_of_spot_review(spot_id, user_id)
      @spot = Spot.find_by(id: spot_id)

      @spot.spot_reviews.select { |spot_review| spot_review.user_id == user_id }.count
    end

    def check_spot_review_max(spot_id, user_id)
      count_of_spot_review(spot_id, user_id) > 2
    end
  end
end
