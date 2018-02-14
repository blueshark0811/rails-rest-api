class Group < ApplicationRecord
  belongs_to :organization
  has_many :group_users
  has_many :users, through: :group_users

  validates :organization_id, :status, :visibility, presence: true
end
