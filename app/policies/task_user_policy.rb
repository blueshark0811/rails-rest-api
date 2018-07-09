class TaskUserPolicy < ApplicationPolicy
  include PolicyHelper::Commentable
  def permitted_attributes
    %i[status]
  end

  def show?
    student? && author? ||
    teacher? && user.in_group_of_course?(record.course)
  end

  def comments_create?
    record.task.question? && show?
  end
end
