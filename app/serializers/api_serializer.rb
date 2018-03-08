module ApiSerializer
  extend ActiveSupport::Concern

  included do
    battributes = base_attributes

    unless battributes.blank?
      attributes(*battributes)

      battributes.each do |field|
        define_method field do
          if available_fields.include?(field)
            type_cast(field)
          else
             ActiveModel::FieldUpgrade::ATTR_NOT_ACCEPTABLE
          end
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
      return [] unless serializable_class

      serializable_class.policy_base_attributes
    end
  end

  def available_fields
    key = params[:action]||:base

    @available_fields ||= {}

    return @available_fields[key] if @available_fields[key]

    return [] unless self.class.serializable_class

    @available_fields[key] = if object.is_a?(self.class.serializable_class)
      object.policy_available_attribute(user_context, params[:action])
    else#in case searchkick
      return [] unless pclass = self.class.serializable_class.policy_class

      pclass.new(user_context, object).api_attributes(params[:action])
    end

    @available_fields[key] 
  end

  def type_cast field
    res = object.send(field)
    type = nil

    begin
      if object.is_a?(Searchkick::HashWrapper) && searchkickable_class
        case searchkickable_class.column_of_attribute(field).type
        when :integer
          res = res.to_i
        when :string
          res = res.to_s
          #todo else
        end
      else
        case object.class.column_of_attribute(field).type
        when :datetime
          res = res.to_s(:long) unless res.blank?
        end
      end
    rescue
    end

    res
  end

  def searchkickable_class
    object._type.classify.constantize rescue nil
  end
end
