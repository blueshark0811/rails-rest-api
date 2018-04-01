class CommentJob < ApplicationJob
  queue_as :default

  def perform(comment)
    comment.write_activity
  end
end
