# frozen_string_literal: true

class GroupPolicy < OrganizationEntityPolicy
  class Scope < Scope
    def condition
      return none unless role

      res = { organization_id: organization.id }

      if role == 'student'
        #showing to students only public groups or private too that he participated
        res[:_or] = [{visibility: 'public'}, {user_ids: user.id}]
      end

      res
    end
  end

  def comments_index?
    update? || user.group_users.where(group_id: record.id).exists?
  end

  def show_activity?
    comments_index?
  end

  def permitted_attributes
    %i[description status title user_limit visibility]
  end

  def api_base_attributes
    super + [:participated]
  end
end
