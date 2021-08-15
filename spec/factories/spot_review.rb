FactoryBot.define do
  factory :spot_review do
    spot { Spot.all.sample }
    user
    sequence(:posted_at) { |n| Time.zone.now - n.days }
    sequence(:comment) { |n| "#{n}コメントコメントコメントコメントコメントreviewのコメント" }
    sequence(:view_count) { |n| n }
  end
end
