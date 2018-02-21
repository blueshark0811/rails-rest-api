# frozen_string_literal: true

class Api::V1::ApiController < ActionController::API
  include SharedController

  before_action :authenticate_user!
  before_action :set_current_time_zone
  before_action :set_locale

  serialization_scope :view_context

  before_action do
    self.namespace_for_serializer = Api::V1
  end

  rescue_from JWT::DecodeError do |exception|
    render_error exception.message, '', 401
  end

  def set_current_time_zone
  #   old_time_zone = Time.zone
  #   Time.zone = 'Eastern Time (US & Canada)' # todo
  # # yield
  # rescue
  #   Time.zone = old_time_zone
  end

  def render_not_found
    render_result({ success: false }, 404)
  end

  def render_error(message = nil, error_code = '', status = 400, send_report = false, attrs = {})
    if send_report && message && !message.is_a?(String)
      # Mailer.error_occurred(message, false, params.merge(current_user_id: current_user.try(:id), current_user_name: current_user.try(:name), request_host: request.host, request_path: request.path).to_json).deliver
    end

    if message.is_a?(ApplicationRecord)
      render_result message, status, errors: message.errors.details
    else
      render_result(attrs.merge(error_code: error_code, errors: [message]), status)
    end
  end

  def render_result(json, status = 200, meta = nil)
    json.merge!(@additional_attrs_for_render) if @additional_attrs_for_render && json.respond_to?(:merge)

    root = json.base_class.to_s.underscore rescue nil

    root = root.pluralize if root.respond_to?(:size)

    res = {
      json: json,
      root: root,
      status: status,
      meta: meta || result_meta(json),
      serializer_params: { currnet_user: current_user }
    }

    debug res

    render res
  end

  def result_meta(obj)
    meta = {}
    meta[:total_pages] = obj.total_pages if obj.respond_to?(:total_pages)
    meta[:size] = obj.size if obj.respond_to?(:size)
    meta[:limit_value] = obj.limit_value if obj.respond_to?(:limit_value)
    meta[:current_page] = obj.current_page if obj.respond_to?(:current_page)
    meta
  end

  def set_locale
    return unless I18n.config.available_locales.include?(params[:locale]&.to_sym)

    I18n.locale = params[:locale]
  end

  protected

  def jwt(resource)
    return unless resource.confirmed?

    resource.remember_me!

    JWT.encode(
      {
        id: resource.id,
        exp: resource.remember_expires_at.to_i,
        type: resource.class.to_s.downcase,
        email: resource.email
      },
      APP_CONFIG['api']['jwt']['secret'], APP_CONFIG['api']['jwt']['algorithm']
    )
  end

  private

  def authenticate_user!(_opts = {})
    return true if current_user

    token = (request.headers['Authorization'] || params[:authorization]).to_s.split(' ').last

    if token.present?
      attrs = JWT.decode token, APP_CONFIG['api']['jwt']['secret'], APP_CONFIG['api']['jwt']['algorithm']

      if (user = User.where(id: attrs.first['id']).last) && !user.remember_expired?
        sign_in('user', user) && return
      end
    end

    invalid_login_attempt && return
  end

  def invalid_login_attempt(status = 401)
    warden.custom_failure!
    render_error 'Error with your login', nil, status
  end
end
