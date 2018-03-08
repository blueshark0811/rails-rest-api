class ActionPolicy < ApplicationPolicy
  def permitted_attributes
    %i[action_type description]
  end
end
