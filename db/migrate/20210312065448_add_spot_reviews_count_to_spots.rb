class AddSpotReviewsCountToSpots < ActiveRecord::Migration[6.0]
  def change
    add_column :spots, :spot_reviews_count, :integer
  end
end
