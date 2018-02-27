FactoryBot.define do
  factory :group do
    organization

    title Faker::Company.name
    description Faker::Company.bs
    user_limit 10
    visibility 'public'
    status 'active'
  end

  factory :group_user do
    group
    user
    status GroupUser.statuses.first.first
  end
end
