module ApiAttributes
  def api_properties_for_swagger object, options = {}
    attrs = api_object_attriubtes(object, options)
  
    res = {}.with_indifferent_access

    return res unless attrs

    attrs.each do |field|
      next unless attributes.include?(field)

      res[field] = api_prepare_property field
    end

    res
  end

  protected

  def api_object_attriubtes object, options = {}
    serializer_file = Rails.root.join("app/serializers/api/v#{API_VERSION}/#{name.underscore}_serializer.rb")

    return unless File.exist?(serializer_file)

    require serializer_file

    klass = "Api::V#{API_VERSION}::#{name}Serializer"

    return unless Object.const_defined?(klass)

    klass = Object.const_get klass

    klass.new(object, options).attributes.keys
  end

  def api_prepare_property field
    col = column_for_attribute(field)

    res = { type: col.type }
    res["x-nullable"] = true if col.null

    if enum_values = defined_enums[field.to_s]
      res.merge!(enum: enum_values.keys)
    end

    res
  end
end
