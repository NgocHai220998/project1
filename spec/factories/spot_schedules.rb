FactoryBot.define do
  factory :spot_schedule do
    kind { 1 }
    season { 1 }
    start_on { "2021-06-26 15:08:25" }
    end_on { "2021-06-26 15:08:25" }
    day_of_week { "MyString" }
    hour { "MyString" }
    note { "MyString" }
    spot { nil }
  end
end
