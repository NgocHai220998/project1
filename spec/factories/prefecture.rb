FactoryBot.define do
  factory :prefecture do
    name {Faker::Name}
    name_spoken {Faker::Name}
  end
end
