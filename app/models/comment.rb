class Comment < ApplicationRecord
  COMMENTABLES = %w[Group]

  treeable main_root_foreign_key: :main_root_id, tree_path_field: :tree_path

  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :body, presence: true

  def organization_id
    commentable.try :organization_id
  end
end
