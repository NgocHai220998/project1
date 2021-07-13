FactoryBot.define do
  factory :spot do
    prefecture
    tag
    sequence(:name) { |n| "#{n}原生花園" }
    sequence(:body) { |n| "#{n}厚岸海岸チンベの鼻一帯の台地上に，野性のヒオウギアヤメ厚岸海岸チンベの鼻一帯の台地上に，野性のヒオウギアヤメ"}
    
    trait :with_spot_review do
      after(:create) do |spot|
        FactoryBot.create_list(:spot_review, rand(1..50), spot: spot)
      end
    end

    trait :with_spot_schedule do
      transient do
        start_on { Time.zone.now - rand(11..30).days }
        end_on { Time.zone.now - rand(1..10).days }
      end
      
      after(:build) do |spot, evaluator|
        spot.spot_schedules << FactoryBot.create(:spot_schedule, start_on: evaluator.start_on, end_on: evaluator.end_on)
      end
    end
  end
end
