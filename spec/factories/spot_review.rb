FactoryBot.define do
  factory :spot_review do
    spot { Spot.all.sample }
    sequence(:user_id) { |n| n }
    sequence(:posted_at) { |n| Time.zone.now - n.days }
    sequence(:comment) { |n| "#{n}コメントコメントコメントコメントコメントreviewのコメント" }
    sequence(:view_count) { |n| n }
  end
end
