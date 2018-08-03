require_relative "file_factory"

FactoryBot.define do
  factory :attachment do
    organization
    title Faker::Company.name
    description Faker::Company.bs
    user
    data FakeFile.file
    attachmentable { create :organization }

    trait :reindex do
      after(:create) do |object, _evaluator|
        object.reindex(refresh: true)
      end
    end
  end
end
