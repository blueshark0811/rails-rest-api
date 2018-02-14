class GroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :user_id, :group_id, presence: true
  validates :user_id, uniqueness: {scope: [:group_id]}
end
