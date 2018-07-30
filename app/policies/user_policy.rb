# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def condition
      return {} if super_admin?

      { organization_ids: organization.id }
    end
  end

  def send_set_password_link?
    user.id == record.id || admin?
  end

  def permitted_attributes_for_update
    attrs = permitted_attributes_for_create

    if admin?
      attrs << {
        organization_users_attributes: %i[id] + OrganizationUserPolicy.permitted_attributes_shared
      }
    end

    attrs
  end

  def author?
    user && user.id == record.id
  end

  def be_opponent?
    !!record&.role(organization)
  end

  def show_activity?
    author?
  end

  def permitted_attributes_for_create
    %i[
      address avatar country_id state_id zip_code date_of_birth phone_number
      first_name last_name email password password_confirmation enable_email_notifications notify_on_private_message notify_on_course_response notify_on_group_discussion_response get_weekly_activity_summary
    ]# << {group_ids: []}
  end

  def api_base_attributes
    super + [:organization_settings]
  end

  def api_base_attributes_exclude
    %i[confirmation_sent_at confirmed_at current_sign_in_at
       current_sign_in_ip encrypted_password last_sign_in_at
       last_sign_in_ip remember_created_at reset_password_sent_at
       reset_password_token sign_in_count confirmation_token unconfirmed_email admin_role]
  end
end
