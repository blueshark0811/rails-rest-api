class Attachment < ApplicationRecord
  belongs_to :user
  belongs_to :organization
  belongs_to :attachmentable, polymorphic: true, optional: true

  mount_uploader :file, FileUploader
end
