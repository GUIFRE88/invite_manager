FactoryBot.define do
  factory :invite do
    name { "Test Invite" }
    date_completion { Date.today }
  end
end