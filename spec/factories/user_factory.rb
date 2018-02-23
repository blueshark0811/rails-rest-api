# frozen_string_literal: true

FactoryBot.define do
  
  factory :user do
    transient do
      with_organization true
      role 'admin'
      organization nil
    end

    first_name Faker::Name.name
    last_name Faker::Name.name
    email { Faker::Internet.email }
    password Faker::Internet.password
    confirmed_at Time.zone.now

    country
    state

    after(:create) do |object, evaluator|
      if evaluator.with_organization
        organization = evaluator.organization || create(:organization)
        create :organization_user, organization: organization, user: object, role: evaluator.role
      end
    end

    factory :admin_user do
      user role: 'admin_user'
    end
  end
end
