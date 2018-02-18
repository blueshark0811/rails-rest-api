module Lessons
  module Relations
    extend ActiveSupport::Concern

    included do
      belongs_to :user #author
      belongs_to :course
      has_one :course, through: :course
      has_many :attachments, as: :attachmentable
    end

    module ClassMethods
    end
  end
end
