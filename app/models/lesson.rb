class Lesson < ApplicationRecord
  include Lessons::Relations

  enumerate :status

  validates :title, presence: true

  def organization_ids
    @organization_ids ||= course&.organization_ids
  end

  def add_student(user, group_or_course_group)
    unless group_or_course_group.is_a?(CourseGroup)
      group_or_course_group = group_or_course_group.course_groups.find_by(course_id: course_id)
    end

    lesson_users.find_or_create_by(user_id: user.id, course_group_id: group_or_course_group.id)
  end

  def add_user_to_tasks(user, options = {})
    tasks.each do |task|
      task.task_users.create options.merge(user: user)
    end
  end

  class << self
    def additional_attributes
      {
        course_settings: {
          null: true,
          type: :association,
          description: 'course settings for current group',
          association: :course_groups,
          association_type: :object,
          with_params: [:group_id]
        },
        lesson_user_for_current_student: {
          type: :association,
          association: :lesson_users,
          association_type: :array,
          modes: [:for_current_course_group, :for_current_student],
          null: true,
          items: { type: :object, properties: {} },
          description: 'lesson_user instance(association for lesson in which user participated) for current user and course'
        }
      }
    end
  end
end
