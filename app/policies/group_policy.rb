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

  def comments_create?
    root_comment = params.dig('comment', 'root_id').blank?

    update? ||
      user.in_group?(record) &&
      (!student? ||
        (root_comment && record.student_can_post ||
          !root_comment && record.student_can_comment
        )
      )
  end

  def show_activity?
    show?
  end

  def permitted_attributes
    %i[description status title user_limit visibility noticeboard_enabled student_can_post student_can_comment]
  end

  def api_base_attributes
    super + [:participated]
  end
end
