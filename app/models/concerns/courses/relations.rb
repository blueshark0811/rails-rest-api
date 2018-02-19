module Courses
  module Relations
    extend ActiveSupport::Concern

    included do
      belongs_to :user #author
      belongs_to :organization
      has_many :attachments, as: :attachmentable
      has_many :lessons

      has_many :course_groups
      has_many :groups, through: :course_groups
      has_many :precourses, through: :course_groups
    end
  end
end
