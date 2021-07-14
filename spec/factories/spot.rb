FactoryBot.define do
  factory :spot do
    prefecture
    tag
    sequence(:name) { |n| "#{n}原生花園" }
    sequence(:body) { |n| "#{n}厚岸海岸チンベの鼻一帯の台地上に，野性のヒオウギアヤメ厚岸海岸チンベの鼻一帯の台地上に，野性のヒオウギアヤメ"}
    
    trait :with_spot_review_and_spot_schedule do
      transient do
        reviews_count {5}
        start_on { Time.zone.now - rand(11..30).days }
        end_on { Time.zone.now - rand(1..10).days }
      end

      after(:build) do |spot, evaluator|
        spot.spot_reviews << FactoryBot.build_list(:spot_review, evaluator.reviews_count)
        spot.spot_schedules << FactoryBot.build(:spot_schedule, start_on: evaluator.start_on, end_on: evaluator.end_on)
      end
    end
  end
end
