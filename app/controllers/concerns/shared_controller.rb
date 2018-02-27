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

  def organization_subdomain
    return unless request.domain == APP_CONFIG['host']

    request.subdomain
  end

  def organization_domain
    return if request.domain == APP_CONFIG['host']

    request.domain 10
  end

  def current_organization # todo
    return @current_organization if @current_organization

    @current_organization = Organization.find_by(subdomain: organization_subdomain) if organization_subdomain

    @current_organization ||= Organization.find_by(domain: organization_domain) if organization_domain

    @current_organization ||= Organization.find(params[:organization_id]) if params[:organization_id]

    @current_organization ||= current_user&.organizations&.first
  end

  def debug(result)
    if Rails.env.test?
      p '-' * 100
      p 'method ->', request.method
      p 'params ->', params
      p 'Authorization ->', request.headers['Authorization']
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
