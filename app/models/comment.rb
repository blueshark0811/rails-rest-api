class Comment < ApplicationRecord
  COMMENTABLES = %w[Group Task GroupThread]

  treeable main_root_foreign_key: :main_root_id, tree_path_field: :tree_path

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :activities, as: :eventable

  validates :body, presence: true

  after_create_commit { CommentJob.perform_later(self, 'created') }
  after_destroy_commit { CommentJob.perform_later(commentable, 'destroyed') }

  def organization_id
    commentable.try :organization_id
  end

  def opponents
    return [] if root?

    User.where(id: Comment.select(:user_id).where(id: tree_path.pop)).where.not(id: user_id).group(:id)
  end

  def commentable_callback(kount = 1)
    return commentable.comment_created_callback(self) if commentable.respond_to?(:comment_created_callback)

    return unless commentable.respond_to?(:comments_count)

    commentable.update_attribute(:comments_count, commentable.comments_count.to_i + kount)
  end

  def write_activity
    opponents.each do |opponent|
      activities.create(
        notifiable: opponent,
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
      as_object: {
        i18n: 'comment.noticeboard.for_group.created',
        variables: {
          user: Activity.message_link(user),
          commentable: Activity.message_link(commentable)
        }
      }
    )
  end
end
