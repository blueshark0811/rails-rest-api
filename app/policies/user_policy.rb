# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def send_set_password_link?
    user.id == record.id || admin?
  end

  def permitted_attributes_for_update
    attrs = permitted_attributes_for_create

    if admin?
      attrs << { organization_users_attributes:
          %i[
            id role status exclude_students_ids
            files_controll_enabled mesanger_access_enabled
          ]
        }
    end

    attrs
  end

  def permitted_attributes_for_create
    %i[
      address avatar country_id state_id zip_code date_of_birth phone_number
      first_name last_name email password password_confirmation
    ]# << {group_ids: []}
  end

  def api_base_attributes_exclude
    %i[confirmation_sent_at confirmed_at current_sign_in_at
       current_sign_in_ip encrypted_password last_sign_in_at
       last_sign_in_ip remember_created_at reset_password_sent_at
       reset_password_token sign_in_count]
  end
end
