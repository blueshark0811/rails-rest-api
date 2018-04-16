class ActivityPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      sc = scope

      if params['notifiable_id'] == user.id && params['notifiable_type'] == 'User' && teacher?
        unless current_organization_user.activity_course_ids.blank?
          sc = sc.where(course_id: sc.current_organization_user.activity_course_ids)
        end

        unless current_organization_user.activity_student_ids.blank?
          sc = sc.where(user_id: sc.current_organization_user.activity_student_ids)
        end
      end

      sc
    end
  end

  def permitted_attributes
    %i[status flagged]
  end

  def update?
    super_admin? ||
    record.notifiable_type == 'User' && record.notifiable_id == user.id ||
    record.notifiable_type == 'Group' && admin?
  end

  def destroy?
    update?
  end

  def api_base_attributes
    super + [:teachers]
  end
end
