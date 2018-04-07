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

    lesson_users.create user: user, course_group: group_or_course_group
  end
end
