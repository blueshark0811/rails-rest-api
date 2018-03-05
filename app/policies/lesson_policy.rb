class LessonPolicy < ApplicationPolicy
  def permitted_attributes
    %i[description status title]
  end
end
