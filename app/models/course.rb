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
      course_users_state: course_users.map(&:to_index),
      "image" => image.to_json
    )
  end

  validates :title, presence: true

  scope :for_student, -> (student) {
    joins(:course_users)
      .where(course_users: { user_id: student.id })
      .where.not(course_users: { status: 'disabled' })
      .order('course_users.position ASC')
  }

  def active_users
    course_users.in_work
  end

  def add_user(user, course_group)
    course_users.create user: user, course_group: course_group
  end

  def add_user_to_lessons(user, course_group)
    lessons.each do |lesson|
      lesson.lesson_users.create user: user, course_group: course_group
      lesson.add_user_to_tasks user, course_group: course_group
    end
  end

  class << self
    def additional_attributes
      {
        course_users_state: {
          null: true,
          type: :array,
          items: {
            type: :string
          },
          description: '[USER_ID-GROUP_ID-STATUS]'
        },
        course_for_current_user: {
          type: :association,
          association: :course_users,
          association_type: :object,
          modes: [:for_current_course_group, :for_current_user],
          for_roles: 'student',
          null: true,
          items: { type: :object, properties: {} },
          description: "information about user's association to this course"
        },
        lesson_users_for_current_user: {
          type: :association,
          association: :lesson_users,
          association_type: :array,
          modes: [:for_current_course_group, :for_current_user],
          param_conditions: { included_lesson_users_for_current_user: 'true' },
          null: true,
          items: { type: :object, properties: {} },
          description: 'lesson_users instance(association for lesson in which user participated) for current user and course'
        },
        lesson_users: {
          type: :association,
          association: :lesson_users,
          association_type: :array,
          modes: [:for_current_course_group],
          param_conditions: { included_lesson_users: 'true' },
          null: true,
          items: { type: :object, properties: {} },
          description: 'lesson_users instance(association for lesson in which user participated) for course'
        }
      }
    end
  end
end
