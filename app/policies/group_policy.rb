# frozen_string_literal: true

class GroupPolicy < OrganizationEntityPolicy
  include PolicyHelper::Commentable
  include PolicyHelper::Attachmentable

  class Scope < Scope
    def condition
      return none unless role

      res = { organization_id: organization.id }

      if student? || teacher?
        #showing to students/teachers only public groups or private too that he participated
        res[:_or] = [{ visibility: 'public' }, { user_ids: user.id }]
      end

      res
    end
  end

  def show?
    update? || user.in_group?(record)
  end

  def show_activity?
    show?
  end

  def permitted_attributes
    %i[description status title user_limit visibility]
  end

  def api_base_attributes
    super + [:participated]
  end
end
