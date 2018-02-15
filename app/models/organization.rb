class Organization < ApplicationRecord
  include Organizations::Relations

  validates :title, presence: true
  validates :subdomain, format: REGEXP_SUBDOMAIN
  validates :domain, format: REGEXP_DOMAIN, allow_blank: true
end
