FactoryBot.define do
  factory :lesson_user do
    user
    lesson
    course_group

    trait :completed do
      status :completed
    end

  end
end
