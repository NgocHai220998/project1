FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "#{n}高原" }
  end
end
