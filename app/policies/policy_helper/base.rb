module PolicyHelper
  module Base
    def current_organization_user
      @current_organization_user ||= user&.current_organization_user(organization)
    end

    def role
      @role ||= user&.role(organization)
    end

    OrganizationUser.roles.keys.each do |rol|
      define_method "#{rol}?" do
        role == rol || rol == 'admin' && super_admin?
      end
    end

    def super_admin?
      !!user&.super_admin?
    end

    def current_user; user; end
    def current_organization; organization; end
  end
end