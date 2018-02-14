class OrganizationUser < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  enumirate :role

  validates :user_id, :organization_id, :role, presence: true
end
