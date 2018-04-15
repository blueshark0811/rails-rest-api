module Tasks
  module Relations
    extend ActiveSupport::Concern

    included do
      belongs_to :lesson
      belongs_to :user

      has_many :lesson_users, through: :lesson

      has_many :task_users

      has_one :course, through: :lesson
      has_one :organization, through: :course

      has_many :attachments, as: :attachmentable, dependent: :destroy
      has_many :videos, as: :videoable, dependent: :destroy
      has_many :comments, as: :commentable, dependent: :destroy
    end
  end
end
