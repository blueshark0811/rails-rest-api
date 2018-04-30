module Courses
  module Relations
    extend ActiveSupport::Concern

    included do
      belongs_to :user, optional: true #author
      belongs_to :organization, optional: true #if created by admin of organization

      has_many :addon_courses, dependent: :destroy
      has_many :addons, through: :addon_courses
      has_many :organizations_through_addons, through: :addons, source: :organizations

      has_many :attachments, as: :attachmentable, dependent: :destroy
      has_many :lessons, dependent: :destroy
      has_many :lesson_users, through: :lessons

      has_many :course_groups, dependent: :destroy
      has_many :groups, through: :course_groups
      has_many :precourses, through: :course_groups

      has_many :course_users, dependent: :destroy
      has_many :users, through: :course_users
    end
  end
end
