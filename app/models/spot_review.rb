class SpotReview < ApplicationRecord
  belongs_to :spot, counter_cache: true
end
