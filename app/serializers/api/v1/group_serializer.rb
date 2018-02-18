class Api::V1::GroupSerializer < BaseSerializer
  include ApiSerializer
  
  belongs_to :organization
end
