module Users
  module Relations
    extend ActiveSupport::Concern

    included do
      belongs_to :country, optional: true
      belongs_to :state, optional: true

      # as participant
      has_many :organization_users
      has_many :group_users
      has_many :participated_groups, class_name: 'Group', through: :group_users
      has_many :organizations, through: :organization_users

      # as author
      has_many :tasks
      has_many :attachments
      has_many :courses
      has_many :groups
      has_many :files
      has_many :lessons
      has_many :videos
    end

    module ClassMethods
    end
  end
end
