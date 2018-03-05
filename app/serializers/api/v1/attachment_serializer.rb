class Api::V1::AttachmentSerializer < BaseSerializer
  include ApiSerializer

  belongs_to :attachmentable
end
