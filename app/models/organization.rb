require 'socket'

class Organization < ApplicationRecord
  include Organizations::Relations

  domainable :subdomain, { field: :domain, required: false }
  enumerate :language

  validates :title, presence: true

  store_accessor :notification_settings, :notification_email
  store_accessor :display_settings, :display_name, :display_type

  def domain_linked?
    return if domain.blank?

    IPSocket::getaddress(domain) == APP_CONFIG['ip']
  rescue
    false
  end
  alias_method :domain_linked, :domain_linked?

  class << self
    def additional_attributes
      {
        domain_linked: {
          type: :boolean,
          null: true,
          for_roles: ['admin']
        },
        notification_email: {
          type: :string,
          null: true,
          for_roles: ['admin']
        },
        display_name: {
          type: :string,
          null: true,
          for_roles: ['admin']
        },
        display_type: {
          type: :string,
          null: true,
          for_roles: ['admin']
        }
      }
    end
  end
end
