FactoryBot.define do
  factory :comment do
    comment { Faker::Lorem.sentence(3, true) }
    user
    movie
  end
end