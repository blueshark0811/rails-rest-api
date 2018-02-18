FactoryBot.define do
  factory :user do
    first_name Faker::Name.name
    last_name Faker::Name.name
    email { Faker::Internet.email }
    password Faker::Internet.password
    confirmed_at Time.now

    country
    state

    after(:create) do |object|
      organization = create :organization
      create :organization_user, organization: organization, user: object
    end
  end

  factory :admin_user do
    user role: 'admin_user'
  end
end