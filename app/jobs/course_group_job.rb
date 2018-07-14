class CourseGroupJob < ApplicationJob
  queue_as :default

  def perform(course_group)
    course_group.group.students.each do |user|
      course_group.course.add_user user, course_group
    end
  end
end
