module Organizations
  module Relations
    extend ActiveSupport::Concern

    included do
      has_many :organization_users
      has_many :users, through: :organization_users
      has_many :groups
      has_many :courses
      has_many :videos
      has_many :attachments
    end

    module ClassMethods
    end
  end
end
