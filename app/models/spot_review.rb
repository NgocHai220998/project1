class SpotReview < ApplicationRecord
  belongs_to :spot, counter_cache: true
  belongs_to :user
end
