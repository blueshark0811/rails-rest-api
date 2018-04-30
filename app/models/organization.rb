require 'socket'

class Organization < ApplicationRecord
  include Organizations::Relations

  domainable :subdomain, { field: :domain, required: false }
  enumerate :language

  mount_base64_uploader :logo, LogoUploader

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

  def url
    ur = ["#{APP_CONFIG['protocol']}://"]

    ur << (domain_linked? ? domain : "#{subdomain}.#{APP_CONFIG['host']}")

    ur << ":#{APP_CONFIG['port']}" if APP_CONFIG['port'].to_i != 80

    ur.join
  end

  def courses
    return Course.none if new_record?

    Course.where(organization_id: id)
      .or(Course.where(id: AddonCourse.joins("INNER JOIN addon_organizations as ao ON 
        (ao.addon_id = addon_courses.addon_id and ao.organization_id = #{id})").select(:course_id)
      ))
  end

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
