FactoryBot.define do
  factory :lesson_user do
    user
    lesson
    course_group
  end
end
