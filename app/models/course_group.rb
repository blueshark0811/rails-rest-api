class CourseGroup < ApplicationRecord
  belongs_to :course
  belongs_to :group
  belongs_to :precourse, class_name: 'Course'

  enumerate :complete_lesson_can, :status
end
