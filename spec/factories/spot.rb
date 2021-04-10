FactoryBot.define do
  factory :spot do
    prefecture
    tag
    sequence(:name) { |n| "#{n}原生花園" }
    sequence(:body) { |n| "#{n}厚岸海岸チンベの鼻一帯の台地上に，野性のヒオウギアヤメ厚岸海岸チンベの鼻一帯の台地上に，野性のヒオウギアヤメ"}
    
    trait :with_spot_review do
      after(:build) do |spot|
        spot.spot_review << FactoryBot.build_list(:spot_review, rand(1..50))
      end
    end
  end
end
