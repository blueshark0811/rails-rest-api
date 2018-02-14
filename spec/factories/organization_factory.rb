FactoryBot.define do
  factory :organization do
    title Faker::Company.name
    subdomain Faker::Internet.domain_word
    domain Faker::Internet.domain_name
  end

  factory :organization_user do
    user
    organization
    role 'admin'
  end
end