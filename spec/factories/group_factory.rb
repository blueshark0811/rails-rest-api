FactoryBot.define do
  factory :group do
    organization

    title Faker::Company.name
    description Faker::Company.bs
    user_limit 10
    visibility 'public'
    status 'active'
    noticeboard_enabled true
    student_can_post true
    student_can_comment true

    trait :reindex do
      after(:create) do |object, _evaluator|
        object.reindex(refresh: true)
      end
    end
  end

  factory :group_user do
    group
    user
    status GroupUser.statuses.first.first

    trait :reindex do
      after(:create) do |object, _evaluator|
        object.reindex(refresh: true)
      end
    end
  end
end
