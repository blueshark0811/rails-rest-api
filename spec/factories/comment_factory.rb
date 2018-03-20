FactoryBot.define do
  factory :comment do
    commentable { create :group }
    user

    body Faker::Lorem.paragraph
    title Faker::Lorem.sentence
  end
end
