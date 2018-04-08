module Users
  module Relations
    extend ActiveSupport::Concern

    included do
      belongs_to :country, optional: true
      belongs_to :state, optional: true

      # as participant
      has_many :organization_users
      has_many :group_users
      has_many :participated_groups, through: :group_users, source: :group
      has_many :organizations, through: :organization_users

      has_many :course_users
      has_many :participated_courses, through: :course_users, source: :course

      has_many :lesson_users
      has_many :participated_lessons, through: :lesson_users, source: :lesson

      # as author
      has_many :tasks
      has_many :attachments
      has_many :courses
      has_many :groups
      has_many :files
      has_many :lessons
      has_many :videos

      has_many :chat_users
      has_many :chats, through: :chat_users
      has_many :chat_messages
      has_many :activities, as: :notifiable, dependent: :destroy
    end

    module ClassMethods
    end
  end
end
