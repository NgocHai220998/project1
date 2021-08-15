FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@gmail.com" }
    sequence(:nickname) { |n| "user#{n}" }
    sequence(:password) { "User1234567890" }
    sequence(:password_confirmation) { "User1234567890" }
  end
end
