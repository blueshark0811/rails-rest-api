class AddonCourse < ApplicationRecord
  belongs_to :addon
  belongs_to :course

  validates :course_id, uniqueness: { scope: [:addon_id] }
end
