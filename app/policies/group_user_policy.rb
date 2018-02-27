class GroupUserPolicy < ApplicationPolicy
  def permitted_attributes
    [:status]
  end
end
