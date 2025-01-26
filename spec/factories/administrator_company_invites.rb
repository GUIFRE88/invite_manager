FactoryBot.define do
  factory :administrator_company_invite do
    association :administrator
    association :company
    association :invite
  end
end