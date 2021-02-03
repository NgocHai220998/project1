class SpotTag < ApplicationRecord
  belongs_to :tag
  belongs_to :spot
end
