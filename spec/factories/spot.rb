FactoryBot.define do
  factory :spot do
    name {Faker::Name}
    body {Faker::Lorem}
    address {Faker::Address}
    base_id {"#{Faker::Number.between(from: 10000, to: 99999)}KANK#{Faker::Number.between(from: 10000000, to: 99999999)}"}
    prefecture_id {Faker::Number.between(from: 1, to: 47)}
  end
end
