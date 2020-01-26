FactoryBot.define do
  factory :user do
    email { "user@netguru.pl" }
    password { "password" }
    password_confirmation { "password" }
    confirmed_at { Time.now }
  end
end