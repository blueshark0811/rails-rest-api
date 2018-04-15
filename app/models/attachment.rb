class Attachment < ApplicationRecord
  ATTACHMENTABLES = %w[Task TaskUser Course Group Lesson Organization Chat ChatMessage]
  SEARCH_FIELDS = %i[file_name title description]
  SORT_FIELDS = %w[file_name title created_at]

  belongs_to :user
  belongs_to :organization
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

  private

  def set_data
    return if organization_id.present? || attachmentable.blank?

    self.organization_id = attachmentable.try(:organization_id)
  end
end
