# frozen_string_literal: true

class Group < ApplicationRecord
  include Groups::Relations
  SEARCH_FIELDS = %i[description title]

  has_many :comments, as: :commentable

  searchkick callbacks: :async, word_start: SEARCH_FIELDS, searchable: SEARCH_FIELDS
  def search_data
    attributes.merge(
      user_ids: user_ids
    )
  end

  enumerate :status, field: :visibility, prefix: true

  validates :organization_id, :title, :status, :visibility, presence: true

  scope :participated_by, lambda { |user|
    joins(:group_users).where(group_users: { user_id: user.id })
  }
end
