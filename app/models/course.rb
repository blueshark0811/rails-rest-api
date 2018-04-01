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

  class << self
    def additional_attributes
      { lesson_users_for_current_user: {
          type: :association,
          association: :lesson_users,
          association_type: :array,
          mode: :for_current_user,
          param_conditions: {included_lesson_users_for_current_user: 'true'},
          null: true,
          items: { type: :object, properties: {} },
          description: 'lesson_users instance(association for lesson in which user participated) for current user and course'
        },
        lesson_users: {
          type: :association,
          association: :lesson_users,
          association_type: :array,
          param_conditions: {included_lesson_users: 'true'},
          null: true,
          items: { type: :object, properties: {} },
          description: 'lesson_users instance(association for lesson in which user participated) for course'
        }
      }
    end
  end
end
