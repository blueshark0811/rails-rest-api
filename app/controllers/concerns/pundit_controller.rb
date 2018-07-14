module PunditController
  extend ActiveSupport::Concern
  include Pundit

  included do
    rescue_from Pundit::NotAuthorizedError do |_exception|
      p _exception
      render_error 'not allowed', '', 401
    end
  end

  def pundit_user
    UserContext.new(current_user, current_organization, params)
  end

  def policy_condition(scope)
    Pundit::PolicyFinder.new(scope).scope!.new(pundit_user, scope).condition
  end
end
