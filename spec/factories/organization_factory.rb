FactoryBot.define do
  factory :organization do
    title Faker::Company.name
    sequence(:subdomain) { |n| "#{Faker::Internet.domain_word}#{n}" }
    sequence(:domain) { |n|  "#{('a'..'zz').to_a[n]}#{Faker::Internet.domain_name}" }
  end

  factory :organization_user do
    user
    organization
    role 'admin'
  end
end
