# frozen_string_literal: true
require Rails.root.join 'spec', 'factories', 'file_factory'
require Rails.root.join 'spec', 'api','rswag_helper'

def api_base_endpoint
  '/api/v1/'
end

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
  additional_parameters = options.fetch(:additional_parameters, [])
  klass = options[:klass]
  slug = get_slug klass, options[:slug]
  url = options[:url] || "#{api_base_endpoint}#{slug}"
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
          sleep 1 if as == :searchkick

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
  additional_parameters = options.fetch(:additional_parameters, [])
  klass = options[:klass]
  slug = get_slug klass, options[:slug]
  url = options[:url] || "#{api_base_endpoint}#{slug}/{id}"
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
  additional_parameters = options.fetch(:additional_parameters, [])
  additional_body = options.fetch(:additional_body, {})
  klass = options[:klass]
  slug = get_slug klass, options[:slug]
  url = options[:url] || "#{api_base_endpoint}#{slug}"
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
          }.merge(additional_body)
        end

        run_test!
      end

      it_behaves_like 'not-aurhorized'
    end
  end
end

def crud_update(options = {})
  additional_parameters = options.fetch(:additional_parameters, [])
  klass = options[:klass]
  slug = get_slug klass, options[:slug]
  url = options[:url] || "#{api_base_endpoint}#{slug}/{id}"
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
  additional_parameters = options.fetch(:additional_parameters, [])
  klass = options[:klass]
  slug = get_slug klass, options[:slug]
  url = options[:url] || "#{api_base_endpoint}#{slug}/{id}"
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
  additional_parameters = options.fetch(:additional_parameters, [])
  klass = options[:klass]
  slug = get_slug klass, options[:slug]
  url = options[:url] || "#{api_base_endpoint}#{get_slug klass, slug}/batch_update"
  description = options[:description] || "Batch update #{klass.name} Details"
  tag = options[:tag] || klass.name.pluralize
  description_200 = options[:description_200] || 'returns status and errors'

  yield if block_given?

  path url do
    # let(:ids) { [ rswag_properties[:object].id ] }

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
                 errors: { type: :array }
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
