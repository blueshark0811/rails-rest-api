class CourseThread < ApplicationRecord
  SORT_FIELDS = %w(title created_at comments_count last_activity_at)

  belongs_to :user
  belongs_to :course_group
  has_one :course, through: :course_group
  has_one :group, through: :course_group
  has_one :organization, through: :group
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :activities, as: :notifiable, dependent: :destroy
  has_many :attachments, as: :attachmentable, dependent: :destroy

  validates :title, presence: true, uniqueness: { scope: [:course_group_id] }

  def organization_id
    organization&.id
  end

  def comment_created_callback(comment)
    self.comments_count += kount
    self.last_activity_at = Time.zone.now

    save(validate: false)

    group.activities.create(
      eventable: commentable,
      user: user,
      as_object: {
        i18n: 'comment.course_thread.created',
        variables: {
          user: Activity.message_link(user),
          thread: Activity.message_link(self)
        }
      }
    )
  end

  def last_comment
    comments.last
  end

  class << self
    def additional_attributes
      {
        last_comment: {
          null: true,
          type: :object
        }
      }
    end
  end
end
