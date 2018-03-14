FactoryBot.define do
  factory :video do
    organization
    title Faker::Company.name
    user
    videoable { create :organization }
    embed_code "<iframe class='sproutvideo-player' src='//videos.sproutvideo.com/embed/a09adabf1215e9c528/4935acdba18e2e1f' width='630' height='354' frameborder='0' allowfullscreen></iframe>"
    length 177
    status 'ready'
    token Faker::Internet.password(30)
  end
end
