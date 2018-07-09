class TaskUserPolicy < ApplicationPolicy
  include PolicyHelper::Commentable
  def permitted_attributes
    %i[status]
  end
end
