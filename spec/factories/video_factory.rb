FactoryBot.define do
  factory :video do
    length 100
    organization
    title Faker::Company.name
    user
    video { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 'test.jpg'), 'image/jpeg') }#todo
    videoable { create :organization }
  end
end
