class Organization < ApplicationRecord
  include Organizations::Relations

  domainable :subdomain, { field: :domain, required: false }

  validates :title, presence: true
end
