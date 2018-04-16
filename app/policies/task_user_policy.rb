class TaskUserPolicy < ApplicationPolicy
  def permitted_attributes
    %i[status]
  end
end
