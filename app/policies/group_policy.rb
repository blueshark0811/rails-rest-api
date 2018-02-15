class GroupPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def permitted_attributes
    [:description, :status, :title, :user_limit, :visibility]
  end
end
