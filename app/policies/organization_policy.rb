# frozen_string_literal: true

class OrganizationPolicy < ApplicationPolicy
  include PolicyHelper::Videoable
  include PolicyHelper::Attachmentable

  def permitted_attributes
    %i[
        address country_id description domain email language
        logo phone state_id subdomain title website zip_code
        notification_email display_name display_type
      ]
  end

  def update?
    super_admin? || author? || admin?
  end

  def show?
    !!role
  end
end
