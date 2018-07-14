class TaskPolicy < OrganizationAddonEntityPolicy
  include PolicyHelper::Commentable
  include PolicyHelper::Videoable
  include PolicyHelper::Attachmentable

  def permitted_attributes
    attrs = %i[action_type description]

    attrs << {
      attachments_attributes: %i[id] + AttachmentPolicy.permitted_attributes_shared
    }

    attrs << {
      videos_attributes: %i[id] + VideoPolicy.permitted_attributes_shared
    }

    attrs
  end

  def lesson_policy
    @lesson_policy ||= LessonPolicy.new(user_context, record.lesson)
  end

  def update?
    lesson_policy.update?
  end

  def show?
    lesson_policy.show?
  end

  def comments_create?
    record.question? && show? || update?
  end

  def attachments_create?
    p 'attachments_create?'*100, record.question?, show?, update?
    record.question? && show? || update?
  end

  def api_base_attributes
    super + [:task_user]
  end
end
