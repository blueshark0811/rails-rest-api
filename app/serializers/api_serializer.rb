module ApiSerializer
  extend ActiveSupport::Concern

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

  def attributes(requested_attrs = nil, reload = false)
    @attributes = nil if reload
    @attributes ||= (self.class._attributes_data.keys|self.class.base_attributes).each_with_object({}) do |(field), hash|
      attr = ActiveModel::Serializer::Attribute.new(field, {})

      next if attr.excluded?(self)
      next unless requested_attrs.nil? || requested_attrs.include?(field)
      hash[label_field(field)] = attr.value(self)
    end
  end

  def label_field(field)
    object.class.column_of_attribute(field).try(:label) || field
  end

  def read_attribute_for_serialization(attr)
    return ActiveModel::FieldUpgrade::ATTR_NOT_ACCEPTABLE if attr.is_a?(Hash)

    return send(attr) if respond_to?(attr)

    return type_cast(attr) if available_fields.include?(attr)

    #associations
    return object.read_attribute_for_serialization(attr) if self.class.serializable_class.reflect_on_association(attr)

    ActiveModel::FieldUpgrade::ATTR_NOT_ACCEPTABLE
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

  def type_cast(field)
    res = nil

    res = object.send(field) if object.respond_to?(field)

    begin
      if object.is_a?(Searchkick::HashWrapper) && searchkickable_class
        case searchkickable_class.column_of_attribute(field).type
        when :integer
          res = res.to_i
        when :float
          res = res.ceil 2
        when :string
          res = res.to_s
          if searchkickable_class.uploaders.has_key?(field.to_sym)
            res = JSON.parse(res) rescue res
          end
          #todo else
        end
      else
        col = object.class.column_of_attribute(field)
        case col.type
        when :association
          if current_organization && col.try(:mode)  == :inside_current_organization
            if object.respond_to?(col.association)#todo for array result, check serializer_params
              res = object.send(col.association).find_by(organization_id: current_organization.id)
              res = res.class.serializer_class_name.constantize.new(res, serializer_params).attributes
            end
          end
        when :datetime
          res = res.to_s(:long) if res
        end
      end
    rescue => e
      p 'error', e
    end
    res
  end

  def searchkickable_class
    object._type.classify.constantize rescue nil
  end
end
