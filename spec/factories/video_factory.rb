FactoryBot.define do
  factory :video do
    organization
    user
    videoable { create :organization }

    title Faker::Company.name
    length 177
    status 'ready'

    factory :video_link do
      video_link 'https://youtu.be/BL50xRTnHTQ'
    end

    factory :sproutvideo do
      embed_code "<iframe class='sproutvideo-player' src='//videos.sproutvideo.com/embed/a09adabf1215e9c528/4935acdba18e2e1f' width='630' height='354' frameborder='0' allowfullscreen></iframe>"
      token Faker::Internet.password(30)
    end
  end
end
