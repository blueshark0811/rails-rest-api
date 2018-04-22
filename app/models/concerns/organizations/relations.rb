module Organizations
  module Relations
    extend ActiveSupport::Concern

    included do
      belongs_to :country
      belongs_to :state

      has_many :organization_users, dependent: :destroy
      has_many :users, through: :organization_users

      has_many :students, -> { where(organization_users: {role: 'student'}) },
        source: :user, through: :organization_users

      has_many :teachers, -> { where(organization_users: {role: 'teacher'}) },
        source: :user, through: :organization_users

        has_many :admins, -> { where(organization_users: {role: 'admin'}) },
        source: :user, through: :organization_users

      has_many :groups, dependent: :destroy
      has_many :courses, dependent: :destroy
      has_many :all_videos, class_name: 'Video', dependent: :destroy #as author
      has_many :all_attachments, class_name: 'Attachment', dependent: :destroy #as author

      has_many :videos, as: :videoable, dependent: :destroy
      has_many :attachments, as: :attachmentable, dependent: :destroy
      has_many :chats, dependent: :destroy
    end
  end
end
