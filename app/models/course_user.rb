# info about participating of student at course
class CourseUser < ApplicationRecord
  belongs_to :course
  belongs_to :user
  belongs_to :course_group
  has_one :group, through: :course_group

  enumerate :status

  validates :user_id, uniqueness: { scope: [:course_group_id] }

  after_commit { course.reindex }
  after_create_commit { CourseUserJob.perform_later self }

  scope :in_work, -> { where(status: %w(active in_progress)) }

  def to_index
    self.class.to_index user_id, group&.id, status
  end

  def can_start?
    (active? || in_progress?) && (
      course_group.precourse_id.blank? ||
      CourseUser.completed.where(user_id: user_id, course_id: course_group.precourse_id).exists?
    )
  end
  alias_method :can_start, :can_start?

  def can_show?
    can_start? # maybe some add here
  end

  class << self
    def to_index user_id, group_id, status
      [user_id, group_id, status].join '-'
    end

    def additional_attributes
      {
        can_start: { type: :boolean }
      }
    end
  end
end
