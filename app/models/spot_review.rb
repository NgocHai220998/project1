class SpotReview < ActiveRecord::Base
  belongs_to :spot, counter_cache: true
end
