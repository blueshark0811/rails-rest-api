# frozen_string_literal: true

module ApiAttributes
  extend ActiveSupport::Concern

  def api_attributes_for_swagger(options)
    attrs = if options.fetch(:data_action, :return) == :return
              api_return_attributes options
            else
              api_receive_attributes options
    end

    return {} unless attrs

    self.class.api_prepare_attributes_for_swagger attrs, options
  end

  module ClassMethods
    def additional_attributes
      {} # { attribute_name: { type: :integer, null: false }, attribute_name2: { type: :string, null: true } }
    end

    #extended columns info of instance with additional_attributes
    def column_of_attribute(name)
      if col = additional_attributes[name.to_sym]
        return OpenStruct.new col
      end

      column_for_attribute name
    end

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

    def policy_file
      Rails.root.join("app/policies/#{name.underscore}_policy.rb")
    end

    def policy_class
      return @policy_class if @policy_class

      return unless File.exist?(policy_file)

      require policy_file

      klass = "#{name}Policy"

      return unless Object.const_defined?(klass)

      @policy_class = Object.const_get klass
    end

    def policy_base_attributes
      return [] unless policy_class

      policy_class.new(UserContext.new, new).api_attributes
    end

    def api_prepare_attributes_for_swagger(attrs, options)
      res = {}.with_indifferent_access

      attrs.each do |field|
        # next unless api_base_attributes.include?(field)

        unless field.is_a?(Hash)
          res[field] = api_prepare_attribute_for_swagger field, options
          next
        end

        key = field.keys.first

        next if (skan = key.to_s.scan(/\A(.+)_attributes\z/)).blank?

        next unless (klass = skan.first.first.singularize.classify.constantize rescue nil)

        res[key] = api_array_of_type :object, klass.api_prepare_attributes_for_swagger(field.values.first, options)
      end

      res
    end

    def api_array_of_type type = nil, properties = {}
      type ||= :integer

      {
        type: :array,
        'x-nullable' => true,
        items: {
          type: type,
          properties: properties
        }
      }
    end

    def api_prepare_attribute_for_swagger(field, options = {})
      col = column_of_attribute(field)

      res = { }

      if description = col.try(:description).presence
        res[:description] = description
      end

      res[:type] = :object if uploaders.keys.include?(field)

      res[:type] ||= col.type

      if res[:type] == :association
        res[:type] = col.try :association_type
      end

      unless res[:type]
        res[:type] = field.to_s.match(/_ids/) ? :array : :string
      end

      if res[:type] == :array
        return api_array_of_type(col.try(:items).try(:type), col.try(:items).try(:properties)||{})
      end

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
    # res += self.class.additional_attributes.keys.map(&:to_sym)
    res.uniq
  end

  def policy_available_attribute(user_context, action)
    return [] unless pclass = self.class.policy_class

    pclass.new(user_context, self).api_attributes(action)
  end

  protected

  # attributes that api receive, for ex: for update/create actions
  def api_receive_attributes(options = {})
    policy_available_attribute(
      UserContext.new(
        options[:current_user], options[:current_organization]
      ),
      options.dig(:params, :action)
    )
  end

  #attributes that returns api
  def api_return_attributes(options = {})
    self.class.serializer&.new(self, serializer_params: options)&.attributes&.keys&.map(&:to_sym)
  end
end
