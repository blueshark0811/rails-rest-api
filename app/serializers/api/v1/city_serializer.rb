class Api::V1::CitySerializer < BaseSerializer
  include ApiSerializer
  
  belongs_to :state
end
