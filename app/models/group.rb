# frozen_string_literal: true

class Group < ApplicationRecord
  include Groups::Relations

  enumerate :status, field: :visibility, prefix: true

  validates :organization_id, :status, :visibility, presence: true

  scope :participated_by, lambda { |user|
    joins(:group_users).where(group_users: { user_id: user.id })
  }
end
