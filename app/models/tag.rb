class Tag < ApplicationRecord
  has_many :spot_tag, dependent: :destroy
end
