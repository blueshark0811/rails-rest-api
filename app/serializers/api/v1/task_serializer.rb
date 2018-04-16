class Api::V1::TaskSerializer < BaseSerializer
  include ApiSerializer

  has_many :attachments
  has_many :videos
end
