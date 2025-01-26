FactoryBot.define do
  factory :administrator do
    name { "Test Administrator" }
    email { "admin@example.com" }
    password { "password123" }
  end
end