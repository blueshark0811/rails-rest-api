class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def permitted_attributes
    [:first_name, :last_name, :email, :password, :password_confirmation]
  end
end
