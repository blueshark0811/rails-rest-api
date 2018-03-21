class Api::V1::ChatUserSerializer < BaseSerializer
  include ApiSerializer

  belongs_to :user
end
