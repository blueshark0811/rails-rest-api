FactoryBot.define do
  factory :task_user do
    task
    user
    course_group
  end
end
