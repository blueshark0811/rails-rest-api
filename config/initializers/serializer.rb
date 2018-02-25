ActiveModelSerializers.config.adapter = :json

module ActiveModel
  module FieldUpgrade
    ATTR_NOT_ACCEPTABLE = '_not_acceptable_'.freeze

    def excluded?(serializer)
      if condition_type == :if
        !evaluate_condition(serializer)
      elsif condition_type == :unless
        evaluate_condition(serializer)
      elsif value(serializer) == ATTR_NOT_ACCEPTABLE
        true
      else
        false
      end
    end
  end
end

ActiveModel::Serializer::Attribute.class_eval do
  include ActiveModel::FieldUpgrade
end

ActiveModel::Serializer::Reflection.class_eval do
  include ActiveModel::FieldUpgrade

  def value(serializer, include_slice = nil)
    @object = serializer.object
    @scope = serializer.scope

    block_value = instance_exec(serializer, &block) if block
    return unless include_data?(include_slice)

    if block && block_value != :nil
      block_value
    else
      serializer.read_attribute_for_serialization(name)
    end
  end
end
