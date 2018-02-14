class Organization < ApplicationRecord
  has_many :organization_users
  has_many :users, through: :organization_users

  validates :title, presence: true
  validates :subdomain, format: REGEXP_SUBDOMAIN
  validates :domain, format: REGEXP_DOMAIN, allow_blank: true

end
