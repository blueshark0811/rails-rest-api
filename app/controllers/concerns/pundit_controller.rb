
module PunditController
  extend ActiveSupport::Concern
  include Pundit

  def pundit_user
    UserContext.new(current_user, current_organization)
  end
end
