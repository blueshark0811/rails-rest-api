class Api::V1::VideoSerializer < BaseSerializer
  include ApiSerializer

  belongs_to :videoable
end
