class Attachment < ApplicationRecord
  ATTACHMENTABLES = %w[Task TaskUser Course Group Lesson Organization Chat ChatMessage]
  SEARCH_FIELDS = %i[file_name title description]
  SORT_FIELDS = %w[file_name title created_at]

  belongs_to :user
  belongs_to :organization, optional: true
  belongs_to :attachmentable, polymorphic: true, optional: true

  mount_base64_uploader :data, FileUploader

  searchkick callbacks: :async, word_start: SEARCH_FIELDS, searchable: SEARCH_FIELDS
  def search_data
    attributes.merge(
      file_name: data&.file&.filename || '',
      'title' => title || ''
    )
  end

  validates :data, presence: true

  before_validation :set_data

  after_create_commit { AttachmentJob.perform_later(self, 'created') }
  after_destroy_commit { AttachmentJob.perform_later(attachmentable, 'destroyed') }

  def attachmentable_callback
    if attachmentable.respond_to?(:attachment_created_callback)
      return attachmentable.attachment_created_callback(self)
    end

    return unless attachmentable.respond_to?(:attachments_count)

    attachmentable.update_attribute(:attachments_count, attachmentable.attachments_count.to_i + 1)
  end

  private

  def set_data
    return if organization_id.present? || attachmentable.blank?

    self.organization_id = attachmentable.try(:organization_id)
  end
end
