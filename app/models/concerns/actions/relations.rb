module Actions
  module Relations
    extend ActiveSupport::Concern

    included do
      belongs_to :lesson
      belongs_to :user

      has_one :course, through: :lesson

      has_many :attachments, as: :attachmentable, dependent: :destroy
      has_many :videos, as: :videoable, dependent: :destroy
    end
  end
end
