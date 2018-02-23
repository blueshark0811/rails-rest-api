# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
  
  def permitted_attributes
    %i[first_name last_name email password password_confirmation]
  end

  def api_base_attributes_exclude
    [:confirmation_sent_at, :confirmed_at, :current_sign_in_at, 
    :current_sign_in_ip, :encrypted_password, :last_sign_in_at, 
    :last_sign_in_ip, :remember_created_at, :reset_password_sent_at, 
    :reset_password_token, :sign_in_count]
  end
end
