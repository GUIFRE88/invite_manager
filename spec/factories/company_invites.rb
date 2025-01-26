FactoryBot.define do
  factory :company_invite do
    association :company
    association :invite
  end
end
