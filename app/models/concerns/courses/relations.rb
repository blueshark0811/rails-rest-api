module Courses
  module Relations
    extend ActiveSupport::Concern

    included do
      belongs_to :user #author
      belongs_to :organization
      has_many :attachments, as: :attachmentable, dependent: :destroy
      has_many :lessons, dependent: :destroy

      has_many :course_groups, dependent: :destroy
      has_many :groups, through: :course_groups
      has_many :precourses, through: :course_groups

      has_many :course_users, dependent: :destroy
      has_many :users, through: :course_users
    end
  end
end
