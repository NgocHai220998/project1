FactoryBot.define do
  factory :prefecture do
    sequence(:name) { |n| "#{n}北海道" }
    sequence(:name_spoken) { |n| "#{n}ほっかいどう" }
  end
end
