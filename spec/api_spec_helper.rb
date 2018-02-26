module RswagHelper
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

  def rswag_set_schema example, options = {}
    example.metadata[:response][:schema] = rswag_get_schema(options)
  end

  def rswag_set_error_schema example, options = {}
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
      required: [ 'errors' ]
    }
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

    param = {
      name: options.fetch(:name, :body),
      in: options.fetch(:in, :body),
      schema: rswag_get_schema(options)
    }

    rswag_parameter example, param

    param
  end

  def rswag_get_schema(options = {})
    if options[:type] == :array
      {
        type: :object,
        properties: 
          options.fetch(:properties, {}).merge({
            rswag_root.to_s.pluralize.to_sym => {
              type: :array,
              items: {
                type: :object,
                properties: rswag_item_properties(options.fetch(:action))
              }
            }
          }),
        required: [rswag_root.to_s.pluralize.to_sym]
      }
    else
      {
        type: :object,
        properties:
          options.fetch(:properties, {}).merge({
            rswag_root.to_sym => { 
              type: :object,
              properties: rswag_item_properties(options.fetch(:action))
            }
          }),
        required: [rswag_root.to_sym]
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

module ApiSpecHelper
  include RswagHelper
  # let!(:current_user) { create :user }
  # let(:authorization) { "Bearer #{current_user.jwt_token}" }
  # let(:current_page) { 1 }
  # let(:current_count) { 20 }
  def current_user
    @current_user ||= create :user
  end

  def authorization user = nil
    "Bearer #{(user || current_user).jwt_token}"
  end

  def current_page
    1
  end

  def current_count
    20
  end

  def current_slug
    CURRENT_CLASS.name.split('::').last.underscore.pluralize
  end

  def current_class_name
    CURRENT_CLASS.name
  end
end

shared_examples_for 'not-aurhorized' do
  response '401', 'returns error You are not authorized' do
    let(:authorization) { nil }

    before do |example|
      rswag_set_error_schema example
    end

    run_test! do |response|
      data = JSON.parse(response.body)
      expect(data['errors']).to include "You are not authorized"
    end
  end

  response '428', 'returns error Organization is not determinated' do
    let(:user) { create :user, with_organization: false }
    let(:authorization) { super user }

    before do |example|
      user.organization_users.delete_all
      rswag_set_error_schema example
    end

    run_test! do |response|
      data = JSON.parse(response.body)
      expect(data['errors']).to include "Organization is not determinated"
    end
  end
end

shared_examples_for 'not-found' do
  response '404', 'returns error if instance not found' do
    let(:id) { 0 }

    before do |example|
      rswag_set_error_schema example
    end
    
    run_test! do |response|
      data = JSON.parse(response.body)
      expect(data['errors'].any?{|e| e.match /Couldn't find/}).to be_truthy
    end
  end
end


shared_examples_for 'crud-index' do
  let(:additional_parameters) { [] }
  path "/api/v1/#{current_slug}" do
    get "#{current_class_name.pluralize} inside organization" do
      tags current_class_name.pluralize
      consumes 'application/json'

      parameter name: :authorization, in: :header, type: :string, required: true
      parameter name: :organization_id, in: :query, type: :integer, required: false
      parameter name: :current_page, in: :query, type: :integer, required: false
      parameter name: :current_count, in: :query, type: :integer, required: false

      response '200', 'returns as array' do
        before do |example|
          rswag_set_schema example, action: :index, type: :array

          additional_parameters.each do |parametr|
            rswag_parameter(example, parametr)
          end
        end

        run_test!
      end

      it_behaves_like 'not-aurhorized'
    end
  end
end

shared_examples_for 'crud-show' do
  path "/api/v1/#{current_slug}/{id}" do
    let(:id) { rswag_properties[:object].id }

    get "Get #{current_class_name} Details" do
      before { |example| rswag_set_schema example, action: :show }

      tags current_class_name.pluralize
      consumes 'application/json'

      parameter name: :id, in: :path, type: :integer
      parameter name: :authorization, in: :header, type: :string, required: true

      response '200', 'returns as object' do
        run_test!
      end

      it_behaves_like 'not-aurhorized'
      it_behaves_like 'not-found'
    end
  end
end

shared_examples_for 'crud-update' do
  path "/api/v1/#{current_slug}/{id}" do
    let(:id) { rswag_properties[:object].id }

    put "Update #{current_class_name} Details" do
      before do |example|
        rswag_set_schema example, action: :update
        @parameter = rswag_set_parameter(example, action: :update)
      end
      
      tags current_class_name.pluralize
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :authorization, in: :header, type: :string, required: true

      response '200', 'return data' do
        let(:body) do
          {
            rswag_root => build(rswag_root).attributes.reject do |k,v| 
              v.nil? || !@parameter[:schema][:properties][rswag_root][:properties].keys.include?(k)
            end
          }
        end

        run_test!
      end

      it_behaves_like 'not-aurhorized'
      it_behaves_like 'not-found'
    end
  end
end

shared_examples_for 'crud-delete' do
  path "/api/v1/#{current_slug}/{id}" do
    let(:id) { rswag_properties[:object].id }

    delete "Delete #{current_class_name}" do
      tags current_class_name.pluralize
      consumes 'application/json'

      parameter name: :id, in: :path, type: :integer
      parameter name: :authorization, in: :header, type: :string, required: true

      response '200', "deleting #{current_class_name} account" do
        schema type: :object,
        properties: {
          success: { type: :boolean, value: true }
        },
        required: ['success']

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['success']).to eq true
        end
      end

      it_behaves_like 'not-aurhorized'
      it_behaves_like 'not-found'
    end
  end
end

shared_examples_for 'crud' do
  it_behaves_like 'crud-index'
  it_behaves_like 'crud-show'
  it_behaves_like 'crud-update'
  it_behaves_like 'crud-delete'
end
