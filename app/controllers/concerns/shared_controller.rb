module SharedController
  extend ActiveSupport::Concern
  include PunditController

  included do
    unless %w[development test].include?(Rails.env)
      unless config.consider_all_requests_local
        rescue_from Exception, with: :render_error
      end
    end

    helper_method :current_organization
  end

  def current_page
    params[:current_page] || 1
  end

  def current_count
    params[:current_count] || 20
  end

  def sort_default_flag
    SORT_FLAGS.first
  end

  def sort_flag
    flag = params[:sort_flag].to_s.upcase

    SORT_FLAGS.include?(flag) ? flag : sort_default_flag
  end

  def bparams(*param)
    res = params.dig(*param)
    res == true || res == 'true'
  end

  def base_domain?
    request.domain == APP_CONFIG['host']
  end

  def organization_subdomain
    return unless base_domain?

    request.subdomain
  end

  def organization_domain
    return if base_domain?

    request.domain 10
  end

  def current_organization
    return @current_organization if @current_organization

    @current_organization = Organization.find_by(subdomain: organization_subdomain) if organization_subdomain

    @current_organization ||= Organization.find_by(domain: organization_domain) if organization_domain

    @current_organization
  end

  def debug(result)
    if Rails.env.test?
      p '-' * 100
      p 'method ->', request.method
      p 'params ->', params
      p 'Authorization ->', request.headers['Authorization']
      p 'current user id ->', current_user&.id
      p 'current organization ->', current_organization
      p '-' * 100
    end

    unless Rails.env.production?
      p '*' * 100
      p 'result ->', result
      p '*' * 100
    end
  end

  module ClassMethods
  end
end
