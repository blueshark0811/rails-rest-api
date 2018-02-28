class BaseSerializer < ActiveModel::Serializer
  def context
    view_context rescue nil
  end

  def current_user
    serializer_params[:current_user] || context&.current_user
  end

  def current_organization
    serializer_params[:current_organization] || context&.current_organization
  end

  def user_context
    UserContext.new current_user, current_organization
  end

  def params
    serializer_params[:params] || context&.params || {}
  end

  def serializer_params
    instance_options[:serializer_params] || {}
  end
end
