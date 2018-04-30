class Task < ApplicationRecord
  include Tasks::Relations

  enumerate :action_type

  accepts_nested_attributes_for :attachments
  accepts_nested_attributes_for :videos

  class << self
    def additional_attributes
      {
        task_user: {
          null: true,
          type: :association,
          description: 'task_user - association for user/task/group',
          association: :task_users,
          association_type: :object,
          modes: [:for_current_course_group, :for_current_user]
        }
      }
    end
  end

  def organization_ids
    @organization_ids ||= course&.organization_ids
  end

  def add_student(user, group_or_course_group)
    unless group_or_course_group.is_a?(CourseGroup)
      group_or_course_group = group_or_course_group.course_groups.find_by(course_id: course.id)
    end

    task_users.find_or_create_by(user_id: user.id, course_group_id: group_or_course_group.id)
  end
end
