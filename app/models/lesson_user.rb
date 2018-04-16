class LessonUser < ApplicationRecord
  belongs_to :lesson
  belongs_to :user
  belongs_to :course_group
  has_many :activities, as: :notifiable, dependent: :destroy

  enumerate :status

  after_save :write_activity

  def course_settings
    course_group
  end

  class << self
    def additional_attributes
      {
        course_settings: {
          null: true,
          type: :object,
          description: 'course settings for current group'
        }
      }
    end
  end

  protected

  def write_activity
    return unless saved_changes['status'].blank?

    activities.create(
      eventable: comment,
      user: commentable.user,
      as_object: {
        i18n: "lesson_user.status.#{status}",
        variables: {
          user: Activity.message_link(commentable.user),
          lesson: Activity.message_link(lesson)
        }
      }
    )
  end
end
