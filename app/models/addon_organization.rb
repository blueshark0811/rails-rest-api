class AddonOrganization < ApplicationRecord
  belongs_to :addon
  belongs_to :organization

  validates :addon_id, uniqueness: { scope: [:organization_id] }
end
