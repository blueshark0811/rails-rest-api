class CourseGroup < ApplicationRecord
  belongs_to :course
  belongs_to :group
  belongs_to :precourse, class_name: 'Course'

  enumerate :status, {field: :complete_lesson_can, prefix: true}
end
