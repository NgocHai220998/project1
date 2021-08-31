namespace :spot_reviews_counter do
  task update: :environment do
    Spot.find_each do |spot|
      Spot.reset_counters(spot.id, :spot_reviews)
    end
  end
end
