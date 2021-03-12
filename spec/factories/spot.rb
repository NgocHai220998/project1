FactoryBot.define do
  factory :spot do
    prefecture
    tag
    sequence(:name) { |n| "#{n}原生花園" }
    sequence(:body) { |n| "#{n}厚岸海岸チンベの鼻一帯の台地上に，野性のヒオウギアヤメ厚岸海岸チンベの鼻一帯の台地上に，野性のヒオウギアヤメ"}
    sequence(:spot_reviews_count) { |n| "#{n}" }
  end
end
