module Courses
  module Relations
    extend ActiveSupport::Concern

    included do
      belongs_to :user #author
      belongs_to :organization
      has_many :attachments, as: :attachmentable
      has_many :lessons
    end

    module ClassMethods
    end
  end
end
