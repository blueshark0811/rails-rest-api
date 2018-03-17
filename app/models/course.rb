class Course < ApplicationRecord
  include Courses::Relations
  SORT_FIELDS = %w[title created_at lessons_count active_user_ids]
  SEARCH_FIELDS = %i[title description]

  mount_base64_uploader :image, ImageUploader

  searchkick callbacks: :async, word_start: SEARCH_FIELDS, searchable: SEARCH_FIELDS
  def search_data
    attributes.merge(
      group_ids: group_ids,
      active_user_ids: active_users.pluck(:id),
      "image" => image.to_json
    )
  end

  validates :title, presence: true

  def active_users
    users.active
  end
end
