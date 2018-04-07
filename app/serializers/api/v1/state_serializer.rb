class Api::V1::StateSerializer < BaseSerializer
  include ApiSerializer
  
  belongs_to :country
end
