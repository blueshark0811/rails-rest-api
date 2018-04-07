class Api::V1::CommentSerializer < BaseSerializer
  include ApiSerializer

  belongs_to :commentable
  belongs_to :user
end
