class Api::V1::ChatMessageSerializer < BaseSerializer
  include ApiSerializer

  has_many :attachments
end
