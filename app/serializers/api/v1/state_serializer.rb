class Api::V1::StateSerializer < BaseSerializer
  include ApiSerializer
  
  belongs_to :country
  has_many :users
end
