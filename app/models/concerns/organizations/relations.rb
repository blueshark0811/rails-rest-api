module Organizations
  module Relations
    extend ActiveSupport::Concern

    included do
      has_many :organization_users, dependent: :destroy
      has_many :users, through: :organization_users
      has_many :groups, dependent: :destroy
      has_many :courses, dependent: :destroy
      has_many :videos, dependent: :destroy
      has_many :attachments, dependent: :destroy
    end
  end
end
