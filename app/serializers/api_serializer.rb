module ApiSerializer
  extend ActiveSupport::Concern

  included do
    battributes = base_attributes

    unless battributes.blank?
      attributes(*battributes)

      battributes.each do |field|
        define_method field do
          available_fields.include?(field) ? object.send(field) : ActiveModel::FieldUpgrade::ATTR_NOT_ACCEPTABLE
        end
      end
    end
  end

  module ClassMethods
    def serializable_class_name
      @serializable_class_name ||= name.split('::').last.gsub(/Serializer/, '')
    end

    def serializable_class
      return @serializable_class if @serializable_class

      return unless Object.const_defined?(serializable_class_name)

      @serializable_class = Object.const_get serializable_class_name
    end

    def base_attributes
      return [] if !serializable_class

      serializable_class.policy_base_attributes
    end
  end

  def available_fields
    key = params[:action]||:base

    @available_fields ||= {}

    return @available_fields[key] if @available_fields[key]

    return unless self.class.serializable_class

    @available_fields[key] = object.policy_available_attribute(user_context, params[:action])
  end
end
