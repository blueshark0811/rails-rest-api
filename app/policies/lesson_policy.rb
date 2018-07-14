class LessonPolicy < OrganizationAddonEntityPolicy
  include PolicyHelper::Attachmentable
  include PolicyHelper::Videoable

  class Scope < Scope
    def resolve
      sc = scope

      sc = sc.active if student?

      sc
    end
  end

  def permitted_attributes
    %i[description status title]
  end

  def api_base_attributes
    super + [:course_settings, :lesson_user_for_current_student]
  end

  def show?
    course_policy.show? && easy_show?
  end

  def easy_show?
    !student? || record.active?
  end

  def course_policy
    @course_policy ||= CoursePolicy.new(user_context, record.course)
  end
end
