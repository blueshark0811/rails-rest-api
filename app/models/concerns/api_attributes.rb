module ApiAttributes
  extend ActiveSupport::Concern

  def api_properties_for_swagger(options = {})
    attrs = api_available_attriubtes(options)

    res = {}.with_indifferent_access

    return res unless attrs

     attrs.each do |field|
      next unless api_base_attributes.include?(field)

      res[field] = self.class.api_prepare_property field, options
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

    def api_prepare_property(field, options = {})
      col = column_for_attribute(field)

      res = {}

      res[:type] = :object if uploaders.keys.include?(field)

      # fix for searchkick results..
      if respond_to?(:searchkick_klass) && col.type == :integer && options[:as] == :searchkick
        res[:type] = :string
      end

      res[:type] ||= col.type
      
      res[:type] ||= :string

      res['x-nullable'] = true if col.null

      if enum_values = defined_enums[field.to_s]
        res[:enum] = enum_values.values
      end

      res
    end
  end

  def api_base_attributes
    res = attributes.keys.map(&:to_sym)
    res += search_data.keys.map(&:to_sym) if respond_to?(:search_data)
    res.uniq
  end

  protected

  def api_available_attriubtes(options = {})
    self.class.serializer&.new(self, options)&.attributes&.keys&.map(&:to_sym)
  end
end
