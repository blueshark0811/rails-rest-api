module Groups
  module Relations
    extend ActiveSupport::Concern

    included do
      belongs_to :organization

      has_many :group_users
      has_many :users, through: :group_users

      has_many :course_groups
      has_many :courses, through: :course_groups
      has_many :precourses, through: :course_groups

      has_many :lessons, through: :courses
      has_many :attachments, as: :attachmentable
    end
  end
end
