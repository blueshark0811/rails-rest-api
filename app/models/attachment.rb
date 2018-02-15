class Attachment < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  mount_uploader :file, FileUploader
end
