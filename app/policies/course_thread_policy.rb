class CourseThreadPolicy < OrganizationEntityPolicy
  include PolicyHelper::Commentable
  def permitted_attributes
    %i[title]
  end

  def api_base_attributes
    super + [:last_comment]
  end

  def update?
    super || author?
  end

  def show?
    super && record.course_group&.discussing_enabled?
  end

  def create?
    super || (
      user.in_course_group?(record.course_group) &&
        record.course_group.discussing_enabled? && (
          !student? || record.course_group.student_content_enabled?
        )
    )
  end
end
