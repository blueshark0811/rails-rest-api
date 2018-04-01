class LessonUserPolicy < ApplicationPolicy
  def permitted_attributes
    %i[lesson_id status user_id]
  end
end
