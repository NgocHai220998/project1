FactoryBot.define do
  factory :spot_schedule do
    sequence(:kind) { |n| n }
    sequence(:season) { |n| n }
    sequence(:start_on) { Time.zone.now - rand(11..30).days }
    sequence(:end_on) { Time.zone.now - rand(1..10).days }
    spot
  end
end
