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
        }
      }
    end
  end
end
