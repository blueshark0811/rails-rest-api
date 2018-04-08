class CommentJob < ApplicationJob
  queue_as :default

  def perform(comment_or_commentable, action)
    if action == 'created'
      comment_or_commentable.write_activity
      comment_or_commentable.commentable_counter_cache 1

    elsif action == 'destroyed' && comment_or_commentable.respond_to?(:comments_count)
      comment_or_commentable.update_attribute(
        :comments_count, 
        comment_or_commentable.comments_count.to_i - 1
        )
    end
  end
end
