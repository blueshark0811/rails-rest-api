FactoryBot.define do
  factory :video do
    organization
    length 100
    title Faker::Company.name
    user
    video FakeFile.file
    videoable { create :organization }
  end
end
