module Groups
  module Relations
    extend ActiveSupport::Concern

    included do
      belongs_to :organization

      has_many :group_users, dependent: :destroy
      has_many :users, through: :group_users

      has_many :users_at_organization, -> (group) {
        joins(:organization_users).where(
          organization_users: {
            organization_id: group.organization_id
          }
        )
      }, through: :group_users, source: :user do
        def with_role(role)
          self.where(organization_users: { role: role})
        end
      end

      has_many :course_groups, dependent: :destroy
      has_many :course_threads, through: :course_groups
      has_many :courses, through: :course_groups
      has_many :precourses, through: :course_groups

      has_many :lessons, through: :courses
      has_many :attachments, as: :attachmentable, dependent: :destroy
      has_many :activities, as: :notifiable, dependent: :destroy

      has_many :comments, as: :commentable, dependent: :destroy
    end
  end
end
