class Lesson < ApplicationRecord
  include Lessons::Relations

  enumerate :status

  def organization_id
    @organization_id ||= course&.organization_id
  end

  def add_student(user, group_or_course_group)
    unless group_or_course_group.is_a?(CourseGroup)
      group_or_course_group = group_or_course_group.course_groups.find_by(course_id: course_id)
    end

    lesson_users.find_or_create_by(user_id: user.id, course_group_id: group_or_course_group.id)
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
        # user_settings: {
        #   null: true,
        #   type: :association,
        #   description: 'lesson/course settings for current group and user',
        #   association: :lesson_users,
        #   association_type: :object,
        #   mode: :for_current_user,
        #   # with_params: [{ :course_groups: :group_id }]
        # }
      }
    end
  end
end
