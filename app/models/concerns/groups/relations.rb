module Groups
  module Relations
    extend ActiveSupport::Concern

    included do
      belongs_to :organization
      has_many :group_users
      has_many :users, through: :group_users
    end

    module ClassMethods
    end
  end
end
