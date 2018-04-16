class CourseUserJob < ApplicationJob
  queue_as :default

  def perform(course_user)
    course_user.course.add_user_to_lessons course_user.user, course_user.course_group
  end
end
