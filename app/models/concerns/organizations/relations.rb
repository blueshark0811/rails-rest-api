module Organizations
  module Relations
    extend ActiveSupport::Concern

    included do
      has_many :organization_users
      has_many :users, through: :organization_users
      has_many :groups
      has_many :courses
    end

    module ClassMethods
    end
  end
end
