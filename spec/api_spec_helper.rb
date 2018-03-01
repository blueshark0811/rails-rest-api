# frozen_string_literal: true

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
end

include RswagHelper

def current_user
  @current_user ||= create :user
end

def authorization(user = nil)
  "Bearer #{(user || current_user).jwt_token}"
end

def current_page
  1
end

def current_count
  20
end

def get_slug(klass = nil, slug = nil)
  slug ||= klass.name.split('::').last.underscore.pluralize
end

shared_examples_for 'not-aurhorized' do
  response '401', 'returns error You are not authorized' do
    let(:authorization) { nil }

    before do |example|
      rswag_set_error_schema example
    end

    run_test! do |response|
      data = JSON.parse(response.body)
      expect(data['errors']).to include 'You are not authorized'
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
      expect(data['errors']).to include 'Organization is not determinated'
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
      expect(data['errors'].any? { |e| e.match /Couldn't find/ }).to be_truthy
    end
  end
end

def crud_index(options = {})
  let(:additional_parameters) { [] }

  klass = options[:klass]
  slug = get_slug klass, options[:slug]
  url = options[:url] || "/api/v1/#{slug}"
  description = options[:description] || "Get #{klass.name.pluralize} inside organization"
  tag = options[:tag] || klass.name.pluralize
  description_200 = options[:description_200] || 'returns as array'
  as = options[:as] || :active_model

  yield if block_given?

  path url do
    get description do
      tags tag
      consumes 'application/json'

      parameter name: :authorization, in: :header, type: :string, required: true
      parameter name: :organization_id, in: :query, type: :integer, required: false
      parameter name: :current_page, in: :query, type: :integer, required: false
      parameter name: :current_count, in: :query, type: :integer, required: false

      response '200', description_200 do
        before do |example|
          rswag_set_schema example, action: :index, type: :array, as: as

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

def crud_show(options = {})
  let(:additional_parameters) { [] }

  klass = options[:klass]
  slug = get_slug klass, options[:slug]
  url = options[:url] || "/api/v1/#{slug}/{id}"
  description = options[:description] || "Get #{klass.name} Details"
  tag = options[:tag] || klass.name.pluralize
  description_200 = options[:description_200] || 'returns as object'

  yield if block_given?

  path url do
    let(:id) { rswag_properties[:object].id }

    get description do
      tags tag
      consumes 'application/json'

      parameter name: :id, in: :path, type: :integer
      parameter name: :authorization, in: :header, type: :string, required: true

      response '200', description_200 do
        before do |example|
          rswag_set_schema example, action: :show
          additional_parameters.each do |parametr|
            rswag_parameter(example, parametr)
          end
        end

        run_test!
      end

      it_behaves_like 'not-aurhorized'
      it_behaves_like 'not-found'
    end
  end
end

def crud_create(options = {})
  let(:additional_parameters) { [] }

  klass = options[:klass]
  slug = get_slug klass, options[:slug]
  url = options[:url] || "/api/v1/#{slug}"
  description = options[:description] || "Create #{klass.name}"
  tag = options[:tag] || klass.name.pluralize
  description_200 = options[:description_200] || 'returns created object'

  yield if block_given?

  path url do
    let(:id) { rswag_properties[:object].id }

    post description do
      tags tag
      consumes 'application/json'
      parameter name: :authorization, in: :header, type: :string, required: true

      response '200', description_200 do
        before do |example|
          rswag_set_schema example, action: :show
          @parameter = rswag_set_parameter(example, action: :create)

          additional_parameters.each do |parametr|
            rswag_parameter(example, parametr)
          end
        end

        let(:body) do
          {
            rswag_root => build(rswag_root).attributes.reject do |k, v|
              v.nil? || !@parameter[:schema][:properties][rswag_root][:properties].keys.include?(k)
            end
          }
        end

        run_test!
      end

      it_behaves_like 'not-aurhorized'
    end
  end
end

def crud_update(options = {})
  let(:additional_parameters) { [] }

  klass = options[:klass]
  slug = get_slug klass, options[:slug]
  url = options[:url] || "/api/v1/#{slug}/{id}"
  description = options[:description] || "Update #{klass.name} Details"
  tag = options[:tag] || klass.name.pluralize
  description_200 = options[:description_200] || 'returns data'

  yield if block_given?

  path url do
    let(:id) { rswag_properties[:object].id }

    put description do
      tags tag
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :authorization, in: :header, type: :string, required: true

      response '200', description_200 do
        before do |example|
          rswag_set_schema example, action: :update
          @parameter = rswag_set_parameter(example, action: :update)

          additional_parameters.each do |parametr|
            rswag_parameter(example, parametr)
          end
        end

        let(:body) do
          {
            rswag_root => build(rswag_root).attributes.reject do |k, v|
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

def crud_delete(options = {})
  let(:additional_parameters) { [] }

  klass = options[:klass]
  slug = get_slug klass, options[:slug]
  url = options[:url] || "/api/v1/#{slug}/{id}"
  description = options[:description] || "Delete #{klass.name}"
  tag = options[:tag] || klass.name.pluralize
  description_200 = options[:description_200] || "deleting #{klass.name} account"

  yield if block_given?

  path url do
    let(:id) { rswag_properties[:object].id }

    delete description do
      tags tag
      consumes 'application/json'

      parameter name: :id, in: :path, type: :integer
      parameter name: :authorization, in: :header, type: :string, required: true

      response '200', description_200 do
        before do |example|
          additional_parameters.each do |parametr|
            rswag_parameter(example, parametr)
          end
        end

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

def batch_update(options = {})
  let(:additional_parameters) { [] }

  klass = options[:klass]
  slug = get_slug klass, options[:slug]
  url = options[:url] || "/api/v1/#{get_slug klass, slug}/batch_update"
  description = options[:description] || "Batch update #{klass.name} Details"
  tag = options[:tag] || klass.name.pluralize
  description_200 = options[:description_200] || 'returns status and errors'

  yield if block_given?

  path url do
    let(:id) { rswag_properties[:object].id }

    put description do
      tags tag
      consumes 'application/json'
      parameter name: :ids, in: :body, type: :array, items: { type: :integer }
      parameter name: :authorization, in: :header, type: :string, required: true

      response '200', description_200 do
        before do |example|
          additional_parameters.each do |parametr|
            rswag_parameter(example, parametr)
          end
        end

        schema type: :object,
               properties: {
                 success: { type: :boolean, value: true },
                 errors: { type: :array },
               },
               required: ['success']

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['success']).to eq true
        end
      end

      it_behaves_like 'not-aurhorized'
    end
  end
end

def crud(options = {})
  crud_index options
  crud_show options
  crud_create options
  crud_update options
  crud_delete options
end
