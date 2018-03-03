# frozen_string_literal: true

FactoryBot.define do
  factory :user_context do
    user { create :user }
    organization { create :organization }
    initialize_with { new(attributes) }
  end
end

