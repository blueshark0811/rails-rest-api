FactoryBot.define do
  factory :course_thread do
    user
    course_group

    title { Faker::Lorem.sentence }
  end
end
