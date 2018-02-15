class OrganizationUser < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  enumerate :role

  validates :user_id, :organization_id, :role, presence: true
end
