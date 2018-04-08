class Api::V1::GroupThreadSerializer < BaseSerializer
  include ApiSerializer

  belongs_to :user
end
