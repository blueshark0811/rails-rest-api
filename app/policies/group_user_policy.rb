class GroupUserPolicy < OrganizationEntityPolicy
  class Scope < Scope
    def condition
      return none unless role

      res = { organization_id: organization.id }

      res[:user_id] = user.id if student? || teacher?

      res
    end
  end

  def update?
    author? || super
  end

  def create?
    # author? ||
    super
  end

  def permitted_attributes
    [:status]
  end

  def permitted_attributes_for_create
    [:user_id]
  end
end
