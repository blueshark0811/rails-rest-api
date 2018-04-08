# frozen_string_literal: true

class OrganizationPolicy < ApplicationPolicy
  include PolicyHelper::Videoable
  include PolicyHelper::Attachmentable
  # def permitted_attributes_for_update
  #   attrs = permitted_attributes_for_create
  # end

  # def permitted_attributes_for_create

  # end

  def update?
    super_admin? || author? || admin?
  end

  def show?
    !!role
  end
end
