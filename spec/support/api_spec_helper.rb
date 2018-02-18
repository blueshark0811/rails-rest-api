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

  def rswag_set_schema example, action, type = :object
    p example.metadata[:response][:schema] = rswag_get_schema(action, type)
  end

  def rswag_get_schema action, type = :object
    type == :array ? 
    {
      type: :object,
      properties: {
        rswag_root.pluralize => {
          type: :array,
          items: rswag_item_properties(action)
        }
      },
      required: [rswag_root.pluralize]
    }
    :
    {
      type: :object,
      properties: {
        rswag_root => rswag_item_properties(action)
      },
      required: [rswag_root]
    }
  end

  def rswag_item_properties action
    res = User.api_properties_for_swagger(
      rswag_properties[:current_user], 
      current_user: rswag_properties[:current_user], 
      params: {action: action}
    )

    res
  end
end