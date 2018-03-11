class Video < ApplicationRecord
  VIDEOABLES = %w[Task Organization]
  
  belongs_to :organization
  belongs_to :user
  belongs_to :videoable, polymorphic: true, optional: true

  mount_base64_uploader :video, FileUploader

  validates :video, presence: true
end
