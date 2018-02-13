FactoryBot.define do
  factory :user do
    first_name Faker::Name.name
    last_name Faker::Name.name
    email 'equipengine@yopmail.com'
    password Faker::Internet.password
    confirmed_at Time.now

    country
    state
  end
end