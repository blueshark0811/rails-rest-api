class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def permitted_attributes_for_create
    [:first_name, :last_name, :email, :password, :password_confirmation]
  end

  def permitted_attributes_for_edit
    [:first_name, :last_name]
  end
end
