class LessonUser < ApplicationRecord
  belongs_to :lesson
  belongs_to :user
  belongs_to :course_group

  enumerate :status
end
