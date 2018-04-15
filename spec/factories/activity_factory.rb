FactoryBot.define do
  factory :activity do
    eventable { create :comment }
    notifiable { create :group }
    user { create :user }
    message { { plain_text: Faker::Lorem.sentence } }
    status Activity.statuses.first.first
  end
end
