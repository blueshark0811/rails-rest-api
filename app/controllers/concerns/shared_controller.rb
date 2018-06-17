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
    p 'current_organization->', request.subdomain, request.domain
    return @current_organization if @current_organization

    @current_organization = Organization.find_by(subdomain: organization_subdomain) if organization_subdomain

    @current_organization ||= Organization.find_by(domain: organization_domain) if organization_domain

    @current_organization
  end

  def current_role
    return if !current_user || !current_organization

    @current_role ||= current_user.role(current_organization)
  end

  def super_admin?
    curre_user&.super_admin?
  end

  OrganizationUser.roles.keys.each do |rol|
    define_method "#{rol}?" do
      current_role == rol || rol == 'admin' && super_admin?
    end
  end

  def current_group
    return @current_group if @current_group

    @current_group = @group

    if !@current_group && current_organization && params[:group_id]
      @current_group = current_organization.groups.find_by(id: params[:group_id])
    end

    @current_group
  end

  def current_course
    return @current_course if @current_course

    @current_course = @course

    if !@current_course && current_group && params[:course_id]
      @current_course = current_group.courses.find_by(id: params[:course_id])
    end

    @current_group
  end

  def current_course_group
    return @current_course_group if @current_course_group

    return if !current_group || !current_course

    @current_course_group = current_group.course_groups.find_by(course_id: current_course.id)
  end

  def current_student
    return @current_student if @current_student

    return unless current_organization

    @current_student = if params[:student_id]
      current_organization.students.find_by(id: params[:student_id])
    elsif student?
      current_user
    end
  end

  def debug(result)
    if Rails.env.test?
      p '-' * 100
      p 'method ->', request.method
      p 'params ->', params
      p 'Authorization ->', request.headers['Authorization']
      p 'current user id ->', current_user&.id
      p 'current organization ->', current_organization
      p 'current role ->', current_role
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
