class BaseSerializer < ActiveModel::Serializer
  def current_user
    instance_options[:current_user] || view_context.current_user
  end

  def params
    instance_options[:params] || view_context.params
  end
end