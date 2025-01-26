FactoryBot.define do
  factory :invite do
    name { "Test Invite" }
    created_at { Time.now }
    date_completion { Time.now + 7.days }
  end
end