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
  end
end
