FactoryBot.define do
  factory :action do
    lesson
    user
    course

    action_type 'reading'
    description Faker::Lorem.paragraph
  end
end
