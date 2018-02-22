class GroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :group, counter_cache: :count_participants

  validates :user_id, :group_id, presence: true
  validates :user_id, uniqueness: { scope: [:group_id] }

  validate :validate_limit_participants, on: :create

  protected

  def validate_limit_participants
    return if !group || !group.user_limit || group.user_limit > group.group_users.count

    errors.add :group_id, :limit_reached
    false
  end
end
