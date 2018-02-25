# frozen_string_literal: true

class Group < ApplicationRecord
  include Groups::Relations

  searchkick callbacks: :async, word_start: [:title], searchable: %i[description title]

  enumerate :status, field: :visibility, prefix: true

  validates :organization_id, :status, :visibility, presence: true

  scope :participated_by, lambda { |user|
    joins(:group_users).where(group_users: { user_id: user.id })
  }
end
