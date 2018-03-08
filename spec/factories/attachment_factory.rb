FactoryBot.define do
  factory :attachment do
    organization
    title Faker::Company.name
    description Faker::Company.bs
    user
    data FakeFile.file
    attachmentable { create :organization }
  end
end
