class Comment < ApplicationRecord
  COMMENTABLES = %w[Group TaskUser CourseThread]

  treeable main_root_foreign_key: :main_root_id, tree_path_field: :tree_path

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :activities, as: :eventable
  has_many :attachments, as: :attachmentable, dependent: :destroy

  validates :body, presence: true

  after_create_commit { CommentJob.perform_later(self, 'created') }
  after_destroy_commit { CommentJob.perform_later(commentable, 'destroyed') }
  after_save :move_attachment

  attr_accessor :attachment_id

  class << self
    def additional_attributes
      {
        attachment_id: {
          type: :integer,
          null: false,
          description: 'attachment from thread, that uploaded before and should to be attached to current message'
        }
      }
    end
  end

  def organization_id
    commentable.try :organization_id
  end

  def opponents
    return [] if root?

    User.where(id: Comment.select(:user_id).where(id: tree_path.pop)).where.not(id: user_id).group(:id)
  end

  def commentable_callback
    return commentable.comment_created_callback(self) if commentable.respond_to?(:comment_created_callback)

    return unless commentable.respond_to?(:comments_count)

    commentable.update_attribute(:comments_count, commentable.comments_count.to_i + 1)
  end

  def write_activity
    opponents.each do |opponent|
      activities.create(
        notifiable: opponent,
        user: user,
        as_object: {
          i18n: 'comment.noticeboard.for_user.created',
          variables: {
            user: Activity.message_link(user),
            commentable: Activity.message_link(commentable)
          }
        }
      )
    end

    activities.create(
      notifiable: commentable,
      user: user,
      as_object: {
        i18n: 'comment.noticeboard.for_group.created',
        variables: {
          user: Activity.message_link(user),
          commentable: Activity.message_link(commentable)
        }
      }
    )
  end

  protected

  def move_attachment
    return unless attachment_id

    return unless (attachment = commentable.attachments.find_by id: attachment_id, user_id: user_id)

    attachment.update_attributes attachmentable: self
  end
end
