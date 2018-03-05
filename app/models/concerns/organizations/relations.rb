module Organizations
  module Relations
    extend ActiveSupport::Concern

    included do
      has_many :organization_users, dependent: :destroy
      has_many :users, through: :organization_users
      has_many :groups, dependent: :destroy
      has_many :courses, dependent: :destroy
      has_many :all_videos, class_name: 'Video', dependent: :destroy #as author
      has_many :all_attachments, class_name: 'Attachment', dependent: :destroy #as author

      has_many :videos, as: :videoable, dependent: :destroy
      has_many :attachments, as: :attachmentable, dependent: :destroy
    end
  end
end
