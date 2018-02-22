module ApiSpecHelper
  # let!(:current_user) { create :user }
  # let(:authorization) { "Bearer #{Api::V1::ApiController.new.send :jwt, current_user}" }
  # let(:current_page) { 1 }
  # let(:current_count) { 20 }
  def current_user
    @current_user ||= create :user
  end

  def authorization
    "Bearer #{Api::V1::ApiController.new.send :jwt, current_user}"
  end

  def current_page
    1
  end

  def current_count
    20
  end

  def rswag_properties
    {
      current_user: create(:user),
      object: create(:user)
    }
  end

  def rswag_class
    rswag_properties[:object].class
  end

  def rswag_root
    rswag_class.name.split('::').last.underscore
  end

  def rswag_set_schema example, options = {}
    example.metadata[:response][:schema] = rswag_get_schema(options)
  end

  def rswag_parameter example, attributes
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

    rswag_parameter(
      example, 
      {
        name: options.fetch(:name, :body),
        in: options.fetch(:in, :body),
        schema: rswag_get_schema(options)
      }
    )
  end

  def rswag_get_schema(options = {})
    if options[:type] == :array
      {
        type: :object,
        properties: 
          options.fetch(:properties, {}).merge({
            rswag_root.pluralize => {
              type: :array,
              items: {
                type: :object,
                properties: rswag_item_properties(options.fetch(:action))
              }
            }
          }),
        required: [rswag_root.pluralize]
      }
    else
      {
        type: :object,
        properties:
          options.fetch(:properties, {}).merge({
            rswag_root => { 
              type: :object,
              properties: rswag_item_properties(options.fetch(:action))
            }
          }),
        required: [rswag_root]
      }
    end
  end

  def rswag_item_properties(action)
    rswag_properties[:object].api_properties_for_swagger(
      current_user: rswag_properties[:current_user],
      params: { action: action }
    )
  end
end
