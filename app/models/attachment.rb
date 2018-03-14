class Attachment < ApplicationRecord
  ATTACHMENTABLES = %w[Task Course Group Lesson Organization]

  belongs_to :user
  belongs_to :organization
  belongs_to :attachmentable, polymorphic: true, optional: true

  mount_base64_uploader :data, FileUploader

  validates :data, presence: true

  before_validation :set_data

  private

  def set_data
    return if organization_id.present? || attachmentable.blank?

    self.organization_id = attachmentable.try(:organization_id)
  end
end
