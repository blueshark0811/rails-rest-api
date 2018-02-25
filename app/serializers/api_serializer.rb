module ApiSerializer
  extend ActiveSupport::Concern

  included do
    battributes = base_attributes

    unless battributes.blank?
      attributes(*battributes)

      battributes.each do |field|
        define_method field do
          # p 'a'*100,battributes, available_fields
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

    def serializable_policy_class
      return @serializable_policy_class if @serializable_policy_class

      serializer_file = Rails.root.join("app/policies/#{serializable_class_name.underscore}_policy.rb")

      return unless File.exist?(serializer_file)

      require serializer_file

      klass = "#{serializable_class_name}Policy"

      return unless Object.const_defined?(klass)

      @serializable_policy_class = Object.const_get klass
    end

    def base_attributes
      return [] if !serializable_class || !serializable_policy_class

      serializable_policy_class.new(UserContext.new, serializable_class.new).api_attributes
    end
  end

  def available_fields
    key = params[:action]||:base

    @available_fields ||= {}

    return @available_fields[key] if @available_fields[key]

    return unless self.class.serializable_policy_class

    @available_fields[key] = 
      self.class.serializable_policy_class.new(user_context, object).api_attributes(params[:action])
  end
end
