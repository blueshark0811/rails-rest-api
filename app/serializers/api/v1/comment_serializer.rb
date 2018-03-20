class Api::V1::CommentSerializer < BaseSerializer
  include ApiSerializer
  
  belongs_to :parent
  has_many :children
  belongs_to :commentable
  belongs_to :user
end
