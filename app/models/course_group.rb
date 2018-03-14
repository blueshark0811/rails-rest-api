class CourseGroup < ApplicationRecord
  belongs_to :course
  belongs_to :group
  belongs_to :precourse, class_name: 'Course'

  has_one :organization, through: :group

  enumerate :status, { field: :complete_lesson_can, prefix: true }

  def organization_id
    @organization_id ||= group&.organization_id
  end
end
