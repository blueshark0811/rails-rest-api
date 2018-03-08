FactoryBot.define do
  factory :course do
    title Faker::Company.name
    description Faker::Company.bs
    image FakeFile.file
    organization
    user
  end
end
