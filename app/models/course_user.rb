class CourseUser < ApplicationRecord
  belongs_to :course
  belongs_to :user

  enumerate :status
end
