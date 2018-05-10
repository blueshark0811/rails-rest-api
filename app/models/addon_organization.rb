class AddonOrganization < ApplicationRecord
  belongs_to :addon
  belongs_to :organization
  has_many :courses, through: :addon

  after_create_commit { courses.each { |course| course.reindex } }
  after_destroy_commit { courses.each { |course| course.reindex } }

  validates :addon_id, uniqueness: { scope: [:organization_id] }
end
