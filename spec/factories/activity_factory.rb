FactoryBot.define do
  factory :activity do
    eventable { create :comment }
    notifiable { create :user }

    message { { plain_text: Faker::Lorem.sentence } }
    status Activity.statuses.first.first
  end
end
