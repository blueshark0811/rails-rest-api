class Api::V1::ApiController <  ActionController::API
  include Pundit
  before_action :authenticate_user!
  before_action :set_current_time_zone
  before_action :set_locale
  
  before_action do
    self.namespace_for_serializer = Api::V1
  end

  # respond_to :json

  unless ["development"].include?(Rails.env)
    unless config.consider_all_requests_local
      rescue_from Exception, with: :render_error
    end
  end

  rescue_from JWT::DecodeError do |exception|
    render_error exception.message, "", 401
  end

  def set_current_time_zone
    old_time_zone = Time.zone
    Time.zone = "Eastern Time (US & Canada)" # todo
  # yield
  rescue
    Time.zone = old_time_zone
  end

  def render_not_found
    render_result({ success: false }, 404)
  end

  def render_error(message = nil, error_code = "", status = 400, send_report = true, attrs = {})
    
    if send_report && message && !message.is_a?(String)
     # Mailer.error_occurred(message, false, params.merge(current_user_id: current_user.try(:id), current_user_name: current_user.try(:name), request_host: request.host, request_path: request.path).to_json).deliver
    end

    render_result(attrs.merge(error_code: error_code, errors: [message]), status)
  end

  def debug result
    if Rails.env.test?
      p "-" * 100
      p 'params ->', params
      p 'Authorization ->', request.headers["Authorization"]
      p "-" * 100
    end

    unless Rails.env.production?
      p "*" * 100
      p 'result ->', result
      p "*" * 100
    end
  end

  def render_result(json, status = 200)

    json.merge!(@additional_attrs_for_render) if @additional_attrs_for_render && json.respond_to?(:merge)

    root = json.base_class.to_s.underscore rescue nil

    root = root.pluralize if root.respond_to?(:size)

    res = {json: json, root: root, status: status}
    
    debug res

    render res
  end

  def set_locale
    return unless I18n.config.available_locales.include?(params[:locale]&.to_sym)

    I18n.locale = params[:locale]
  end

  protected

  def jwt(resource)
    return unless resource.confirmed?
    
    resource.remember_me!
    
    JWT.encode({
                 id: resource.id,
                 exp: resource.remember_expires_at.to_i,
                 type: resource.class.to_s.downcase,
                 email: resource.email
               }, APP_CONFIG["api"]["jwt"]["secret"], APP_CONFIG["api"]["jwt"]["algorithm"])
  end

  private

  def authenticate_user!(_opts = {})
    return true if current_user

    token = (request.headers["Authorization"] || params[:authorization]).to_s.split(" ").last

    if token.present?
      attrs = JWT.decode token, APP_CONFIG["api"]["jwt"]["secret"], APP_CONFIG["api"]["jwt"]["algorithm"]

      if (user = User.where(id: attrs.first["id"]).last) && !user.remember_expired?
        sign_in("user", user) && return
      end
    end

    invalid_login_attempt && return
  end

  def invalid_login_attempt(status = 401)
    warden.custom_failure!
    render json: { success: false, message: "Error with your login", status: status }, status: status
  end
end
