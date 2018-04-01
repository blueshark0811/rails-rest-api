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

  class << self
    def additional_attributes
      { participated: {
          type: :association,
          association: :group_users,
          association_type: :object,
          mode: :for_current_user,
          null: true,
          description: 'group_user instance for current user if he participated in group'
        }
      }
    end
  end

  def count_participants
    super.to_i
  end
end
