FactoryBot.define do
  factory :attachment do
    organization
    title Faker::Company.name
    description Faker::Company.bs
    user
    file { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 'test.jpg'), 'image/jpeg') }#todo
    attachmentable { create :organization }
  end
end
