module Lessons
  module Relations
    extend ActiveSupport::Concern

    included do
      belongs_to :user #author
      belongs_to :course
      
      has_many :attachments, as: :attachmentable
    end
  end
end
