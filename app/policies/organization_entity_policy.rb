class OrganizationEntityPolicy < ApplicationPolicy
  def show?
    record.user_id == user.id || record.organization_id == organization.id
  end

  def update?
    super_admin? || admin? || record.user_id == user.id
  end
  def edit?;update?;end
  def new?;update?;end
  def delete?;update?;end
end
