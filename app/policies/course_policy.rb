# frozen_string_literal: true

class CoursePolicy < OrganizationAddonEntityPolicy
  include PolicyHelper::Attachmentable
  class Scope < Scope
    def condition
      return none unless role

      res = { organization_ids: organization.id }

      if student? || teacher?
        # checking for participating in group
        res[:group_ids] = user.group_users.pluck(:group_id)

        if student? # removing disabled courses
          res[:course_users_state] = { not: [] }
          res[:group_ids].each do |group_id|
            res[:course_users_state][:not] << CourseUser.to_index(user.id, group_id, 'disabled')
          end
        end
      end

      res
    end
  end

  def show?
    super_admin? || author? ||
      record_accessible_in_organization? &&
        (admin? ||
          (teacher? && user.in_group_of_course?(record)) ||
          (student? && user.in_course(record)&.can_show?)
        )
  end

  def permitted_attributes
    %i[description image title banner_image]
  end

  def api_base_attributes
    super + %i[lesson_users lesson_users_for_current_student course_for_current_student]
  end
end
