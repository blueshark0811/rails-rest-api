class OrganizationUser < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  enumerate :role, :status

  serialize :exclude_students_ids, Array

  store_accessor :activity_settings, :activity_course_ids, :activity_student_ids

  validates :role, presence: true
  validates :user_id, uniqueness: { scope: [:organization_id] }

  after_commit { user.reindex }

  class << self
    def additional_attributes
      { exclude_students_ids: { type: :array, null: true } }
    end
  end

  def messanger_access_enabled
    !!super
  end

  def files_controll_enabled
    !!super
  end
end
