FactoryBot.define do
  factory :course do
    organization
    user
    title Faker::Company.name
    description Faker::Company.bs
    image FakeFile.file
  end
end
