FactoryBot.define do
  factory :task do
    lesson
    user
    course

    action_type 'reading'
    description Faker::Lorem.paragraph
  end
end
