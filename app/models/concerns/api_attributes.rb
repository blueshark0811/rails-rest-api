module ApiAttributes
  extend ActiveSupport::Concern

  def api_properties_for_swagger(options = {})
    attrs = api_available_attriubtes(options)

    res = {}.with_indifferent_access

    return res unless attrs

    attrs_of_instance = attributes.keys.map(&:to_sym)

    attrs.each do |field|
      next unless attrs_of_instance.include?(field)

      res[field] = self.class.api_prepare_property field
    end

    res
  end

  module ClassMethods
    def serializer_file
      Rails.root.join("app/serializers/api/v#{API_VERSION}/#{name.underscore}_serializer.rb")
    end

    def serializer_class_name
      "Api::V#{API_VERSION}::#{name}Serializer"
    end

    def serializer
      return unless File.exist?(serializer_file)

      require serializer_file

      return unless Object.const_defined?(serializer_class_name)

      Object.const_get serializer_class_name
    end

    def api_prepare_property(field)
      if uploaders.keys.include?(field)
        return { type: :object }
      end

      col = column_for_attribute(field)

      res = { type: col.type }
      res['x-nullable'] = true if col.null

      if enum_values = defined_enums[field.to_s]
        res[:enum] = enum_values.values
      end

      res
    end
  end

  protected

  def api_available_attriubtes(options = {})
    self.class.serializer&.new(self, options)&.attributes&.keys&.map(&:to_sym)
  end
end
