module Trestle
  module Auth
    module ControllerMethods
      extend ActiveSupport::Concern

      included do
        before_action :authenticate_user!
        before_action :require_super_admin!
      end

      protected

      def require_super_admin!
        return if current_user&.super_admin?

        flash[:error] = 'You have not permissions for this action'
        redirect_to '/'
      end
    end
  end
end
