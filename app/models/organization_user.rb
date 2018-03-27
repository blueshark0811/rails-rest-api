class OrganizationUser < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  enumerate :role, :status

  serialize :exclude_students_ids, Array

  validates :user_id, :organization_id, :role, presence: true

  class << self
    def additional_attributes
      { exclude_students_ids: { type: :array, null: true } }
    end
  end

  def mesanger_access_enabled
    !!super
  end

  def files_controll_enabled
    !!super
  end
end
