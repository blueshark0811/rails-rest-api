FactoryBot.define do
  factory :course do
    title Faker::Company.name
    description Faker::Company.bs
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 'test.jpg'), 'image/jpeg') }
    organization
    user
  end
end
