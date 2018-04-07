class OrganizationEntityPolicy < ApplicationPolicy
  class Scope < Scope
    def condition
      return none unless role

      { organization_id: organization.id }
    end
  end

  def show?
    super_admin? || author? || record_accessible_in_organization?
  end

  def update?
    super_admin? || admin? && record_accessible_in_organization?
  end

  def create?
    admin? && record_accessible_in_organization?
  end

  def edit?
    update?
  end

  def new?
    update?
  end

  def destroy?
    update?
  end

  protected

  def record_accessible_in_organization?
    record.organization_id == organization.id && role
  end
end
