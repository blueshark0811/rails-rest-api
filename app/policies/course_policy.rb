# frozen_string_literal: true

class CoursePolicy < OrganizationEntityPolicy
  class Scope < Scope
    def condition
      return none unless role

      res = { organization_id: organization.id }

      if role == 'student'
        res[:group_ids] = user.group_users.pluck(:group_id)
      end

      res
    end
  end

  def permitted_attributes
    %i[description image title]
  end

  def api_base_attributes
    super + [:lesson_users, :lesson_users_for_current_user]
  end
end
