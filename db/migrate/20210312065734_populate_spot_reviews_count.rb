class PopulateSpotReviewsCount < ActiveRecord::Migration[6.0]
  def up
    Spot.find_each do |spot|
      Spot.reset_counters(spot.id, :spot_review)
    end
  end
end
