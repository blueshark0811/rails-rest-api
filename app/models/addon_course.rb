class AddonCourse < ApplicationRecord
  belongs_to :addon
  belongs_to :course

  after_create_commit { course.reindex }
  after_destroy_commit { course.reindex }

  validates :course_id, uniqueness: { scope: [:addon_id] }
end
