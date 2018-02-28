class GroupUserPolicy < ApplicationPolicy
  def permitted_attributes
    [:status]
  end

  def permitted_attributes_for_create
    [:user_id]
  end
end
