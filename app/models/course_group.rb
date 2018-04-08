class CourseGroup < ApplicationRecord
  belongs_to :course
  belongs_to :group
  belongs_to :precourse, class_name: 'Course', optional: true
  has_many :course_users, dependent: :destroy
  has_many :lesson_users, dependent: :destroy

  has_one :organization, through: :group

  enumerate :status, { field: :complete_lesson_can, prefix: true }

  after_commit { course.reindex async: true }

  validates :course_id, uniqueness: { scope: [:group_id] }

  def organization_id
    @organization_id ||= group&.organization_id
  end

  def complete_lesson_can_student?
    super || complete_lesson_can_all?
  end

  def complete_lesson_can_teacher?
    super || complete_lesson_can_all?
  end
end
