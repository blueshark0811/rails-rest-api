FactoryBot.define do
  factory :chat_message do
    user
    chat

    message Faker::Lorem.paragraph
  end
end
