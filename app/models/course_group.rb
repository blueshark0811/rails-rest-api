class CourseGroup < ApplicationRecord
  belongs_to :course
  belongs_to :group
  belongs_to :precourse, class_name: 'Course', optional: true
  has_many :course_users, dependent: :destroy
  has_many :lesson_users, dependent: :destroy
  has_many :course_threads, dependent: :destroy

  has_one :organization, through: :group

  enumerate :status, { field: :complete_lesson_can, prefix: true }

  before_validation :set_default_data
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

  def student_content_enabled?
    discussing_enabled? && super
  end

  protected

  def set_default_data
    # self.discussing_enabled = true if discussing_enabled.nil?
    # self.student_content_enabled = true if student_content_enabled.nil?
    # self.reports_enabled = true if reports_enabled.nil?
    # self.files_enabled = true if files_enabled.nil?
  end
end
