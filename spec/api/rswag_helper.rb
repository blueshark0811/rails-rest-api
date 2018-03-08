
# frozen_string_literal: true

def rswag_properties
  {
    current_user: create(:user),
    object: create(:user)
  }
  end

def rswag_class
  rswag_properties[:class] || rswag_properties[:object].class
end

def rswag_slug
  rswag_root.to_s.pluralize
end

def rswag_root
  rswag_class.name.split('::').last.underscore.to_sym
end

def rswag_set_schema(example, options = {})
  example.metadata[:response][:schema] = rswag_get_schema(options.merge(data_action: :return))
end

def rswag_set_error_schema(example, _options = {})
  example.metadata[:response][:schema] = {
    type: :object,
    properties: {
      errors: {
        type: :array,
        items: {
          type: :string
        }
      }
    },
    required: ['errors']
  }
end

def rswag_parameter(example, attributes)
  if attributes[:in] && attributes[:in].to_sym == :path
    attributes[:required] = true
  end

  if example.metadata.key?(:operation)
    example.metadata[:operation][:parameters] ||= []
    example.metadata[:operation][:parameters] << attributes
  else
    example.metadata[:path_item][:parameters] ||= []
    example.metadata[:path_item][:parameters] << attributes
  end
end

def rswag_set_parameter(example, options)
  options[:action] ||= :update

  param = {
    name: options.fetch(:name, :body),
    in: options.fetch(:in, :body),
    schema: rswag_get_schema(options.merge(data_action: :receive))
  }

  rswag_parameter example, param

  param
end

def rswag_get_schema(options = {})
  if options[:type] == :array
    {
      type: :object,
      properties:
        options.fetch(:properties, {}).merge(
          rswag_root.to_s.pluralize.to_sym => {
            type: :array,
            items: {
              type: :object,
              properties: rswag_item_properties(options)
            }
          }
        ),
      required: [rswag_root.to_s.pluralize.to_sym]
    }
  else
    {
      type: :object,
      properties:
        options.fetch(:properties, {}).merge(
          rswag_root.to_sym => {
            type: :object,
            properties: rswag_item_properties(options)
          }
        ),
      required: [rswag_root.to_sym]
    }
  end
end

def rswag_item_properties(options)
  rswag_properties[:object].api_attributes_for_swagger(
    current_user: rswag_properties[:current_user],
    current_organization: rswag_properties[:current_organization],
    params: { action: options.fetch(:action) },
    as: options.fetch(:as, :active_model),
    data_action: options.fetch(:data_action, :return)
  )
end
