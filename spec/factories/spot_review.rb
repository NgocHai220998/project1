FactoryBot.define do
  factory :spot_review do
    spot { Spot.all.sample }
    sequence(:user_id) { |n| "#{n}" }
    posted_at { Faker::Date.backward(days: 14) }
    sequence(:comment) { |n| "#{n}コメントコメントコメントコメントコメントコメントコメントコメント" }
    sequence(:view_count) { |n| "#{n}" }
  end
end
