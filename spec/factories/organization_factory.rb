FactoryBot.define do
  factory :organization do
    country
    state

    title Faker::Company.name
    sequence(:subdomain) { |n| "#{Faker::Internet.domain_word}#{n}" }
    sequence(:domain) { |n|  "#{('a'..'zz').to_a[n]}#{Faker::Internet.domain_name}" }

    description Faker::Company.name
    address Faker::Company.name
    zip_code Faker::Company.name
    website Faker::Internet.domain_name
    email Faker::Internet.email
    phone Faker::Company.name
    language 'ru'
    notification_settings { { notification_email: Faker::Internet.email } }
    display_settings { { display_name: Faker::Company.name, display_type: "display_name"} }
  end
end
