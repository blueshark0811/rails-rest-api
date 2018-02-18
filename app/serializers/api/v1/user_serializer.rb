class Api::V1::UserSerializer < BaseSerializer
  include ApiSerializer
  
  belongs_to :country
  belongs_to :state
end
