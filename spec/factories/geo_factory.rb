FactoryBot.define do
  factory :country do
    name 'Canada'
  end

  factory :state do
    name 'Toronto'
    country
  end

  factory :city do
    name 'Orlando'
    state
  end
end