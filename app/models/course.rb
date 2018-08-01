class Course < ApplicationRecord
  include Courses::Relations
  SORT_FIELDS = %w[title created_at lessons_count active_user_ids]
  SEARCH_FIELDS = %i[title description]

  mount_base64_uploader :image, ImageUploader

  searchkick callbacks: :async, word_start: SEARCH_FIELDS, searchable: SEARCH_FIELDS
  def search_data
    attributes.merge(
      group_ids: group_ids,
      organization_ids: organization_ids,
      active_user_ids: active_users.pluck(:id),
      course_users_state: course_users.map(&:to_index),
      'image' => image.to_json,
      completed: completed || '',
      incomplete: incomplete || '',
    )
  end

  validates :title, presence: true

  scope :for_student, ->(student) {
    joins(:course_users)
      .where(course_users: { user_id: student.id })
      .where.not(course_users: { status: 'disabled' })
      .order('course_users.position ASC')
  }

  def organizations
    return Organization.where(id: organization_id) if new_record?

    Organization.where("organizations.id IN
      (SELECT ao.organization_id FROM addon_organizations as ao
        INNER JOIN addon_courses as ac ON
        (ao.addon_id = ac.addon_id AND ac.course_id = #{id}))
      #{organization_id ? "OR organizations.id = #{organization_id.to_i}" : ''}"
    )
  end

  def organization_ids
    organizations.pluck(:id)
  end

  def active_users
    course_users.in_work
  end

  def completed
    lesson_users.where(status: "completed").count
  end

  def incomplete
    lesson_users.where(status: "active").count
  end

  def add_user(user, course_group)
    course_users.find_or_create_by user: user, course_group: course_group
  end
  alias_method :add_student, :add_user

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
        course_for_current_student: {
          type: :association,
          association: :course_users,
          association_type: :object,
          modes: [:for_current_course_group, :for_current_student],
          for_roles: 'student',
          null: true,
          items: { type: :object, properties: {} },
          description: "information about user's association to this course"
        },
        lesson_users_for_current_student: {
          type: :association,
          association: :lesson_users,
          association_type: :array,
          modes: [:for_current_course_group, :for_current_student],
          param_conditions: { included_lesson_users_for_current_student: 'true' },
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
        },
        completed: {type: :integer},
        incomplete: {type: :integer}
      }
    end
  end
end
