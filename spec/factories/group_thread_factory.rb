FactoryBot.define do
  factory :group_thread do
    user
    group

    title { Faker::Lorem.sentence }
  end
end
