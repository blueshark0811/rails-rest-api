class BaseSerializer < ActiveModel::Serializer
  def context
    view_context rescue nil
  end

  def current_user
    instance_options[:current_user] || context&.current_user
  end

  def current_organization
    instance_options[:current_organization] || context&.current_organization
  end

  def user_context
    UserContext.new current_user, current_organization
  end

  def params
    instance_options[:params] || context&.params || {}
  end
end
