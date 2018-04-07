class LessonPolicy < OrganizationEntityPolicy
  class Scope < Scope
    def resolve
      scope = scope.active if student?

      scope
    end
  end

  def permitted_attributes
    %i[description status title]
  end

  def show?
    super && (!student? || record.active?)
  end
end
