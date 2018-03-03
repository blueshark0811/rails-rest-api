module Lessons
  module Relations
    extend ActiveSupport::Concern

    included do
      belongs_to :user #author
      belongs_to :course
      
      has_many :attachments, as: :attachmentable, dependent: :destroy

      has_many :lesson_users, dependent: :destroy
      has_many :users, through: :lesson_users
    end
  end
end
