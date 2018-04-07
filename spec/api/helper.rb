# frozen_string_literal: true
require Rails.root.join 'spec', 'factories', 'file_factory'
require Rails.root.join 'spec', 'api','rswag_helper'

def api_base_endpoint
  '/api/v1/'
end

def current_user
  @current_user ||= create :user, :reindex
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

def crud_index(options = {}, &block)
  additional_parameters = options.fetch(:additional_parameters, [])
  exclude_parameters = options.fetch(:exclude_parameters, [])
  parameters = [
    { name: :authorization, in: :header, type: :string, required: true },
    { name: :organization_id, in: :query, type: :integer, required: false },
    { name: :current_page, in: :query, type: :integer, required: false },
    { name: :current_count, in: :query, type: :integer, required: false }
  ].reject { |pa| exclude_parameters.include?(pa[:name]) } + additional_parameters

  klass = options[:klass]
  slug = get_slug klass, options[:slug]
  url = options[:url] || "#{api_base_endpoint}#{slug}"
  description = options[:description] || "Get #{klass.name.pluralize} inside organization"
  tag = options[:tag] || klass.name.pluralize
  description_200 = options[:description_200] || 'returns as array'
  as = options[:as] || :active_model
  check_not_aurhorized = options.fetch(:check_not_aurhorized, true)

  path url do
    get description do
      tags tag
      consumes 'application/json'

      parameters.each { |pa| parameter pa }

      response '200', description_200 do
        before do |example|
          rswag_set_schema example, action: :index, type: :array, as: as

          example.instance_exec(&block) if block

          sleep 1 if as == :searchkick
        end

        run_test!
      end

      it_behaves_like 'not-aurhorized' if check_not_aurhorized
    end
  end
end

def crud_show(options = {})
  additional_parameters = options.fetch(:additional_parameters, [])
  exclude_parameters = options.fetch(:exclude_parameters, [])
  parameters = [
    { name: :id, in: :path, type: :integer },
    { name: :authorization, in: :header, type: :string, required: true }
  ].reject { |pa| exclude_parameters.include?(pa[:name]) } + additional_parameters

  klass = options[:klass]
  slug = get_slug klass, options[:slug]
  url = options[:url] || "#{api_base_endpoint}#{slug}/{id}"
  description = options[:description] || "Get #{klass.name} Details"
  tag = options[:tag] || klass.name.pluralize
  description_200 = options[:description_200] || 'returns as object'
  check_not_aurhorized = options.fetch(:check_not_aurhorized, true)
  check_not_found = options.fetch(:check_not_found, true)

  yield if block_given?

  path url do
    let(:id) { rswag_properties[:object].id }

    get description do
      tags tag
      consumes 'application/json'

      parameters.each { |pa| parameter pa }

      response '200', description_200 do
        before do |example|
          rswag_set_schema example, action: :show
        end

        run_test!
      end

      it_behaves_like('not-aurhorized') if check_not_aurhorized
      it_behaves_like('not-found') if check_not_found
    end
  end
end

def crud_create(options = {}, &block)
  additional_parameters = options.fetch(:additional_parameters, [])
  exclude_parameters = options.fetch(:exclude_parameters, [])
  parameters = [
    { name: :authorization, in: :header, type: :string, required: true }
  ].reject { |pa| exclude_parameters.include?(pa[:name]) } + additional_parameters

  additional_body = options.fetch(:additional_body, {})
  klass = options[:klass]
  slug = get_slug klass, options[:slug]
  url = options[:url] || "#{api_base_endpoint}#{slug}"
  description = options[:description] || "Create #{klass.name}"
  tag = options[:tag] || klass.name.pluralize
  description_200 = options[:description_200] || 'returns created object'
  check_not_aurhorized = options.fetch(:check_not_aurhorized, true)

  path url do
    let(:id) { rswag_properties[:object].id }

    post description do
      tags tag
      consumes 'application/json'

      parameters.each { |pa| parameter pa }

      response '200', description_200 do
        before do |example|
          rswag_set_schema example, action: :show
          @parameter = rswag_set_parameter(example, action: :create)

          example.instance_exec(&block) if block
        end

        let(:body) do
          res = {
            rswag_root => build(rswag_root).attributes.reject do |k, v|
              v.nil? || !@parameter[:schema][:properties][rswag_root][:properties].keys.include?(k)
            end
          }

          additional_body = additional_body.each_with_object({}) do |(k, v), h|
            h[k] = if v.is_a?(Hash)
              v.each_with_object({}) do |(k2, v2), h2|
                h2[k2] = if v2.is_a?(String) && (var = v2.scan(/\{:(.+)\}/).first&.first)
                  send(var)
                else
                  v2
                end
              end
            else
              v
            end
          end

          res.merge(additional_body)
        end

        run_test!
      end

      it_behaves_like('not-aurhorized') if check_not_aurhorized
    end
  end
end

def crud_update(options = {})
  additional_parameters = options.fetch(:additional_parameters, [])
  exclude_parameters = options.fetch(:exclude_parameters, [])
  parameters = [
    { name: :id, in: :path, type: :integer },
    { name: :authorization, in: :header, type: :string, required: true }
  ].reject { |pa| exclude_parameters.include?(pa[:name]) } + additional_parameters

  klass = options[:klass]
  slug = get_slug klass, options[:slug]
  url = options[:url] || "#{api_base_endpoint}#{slug}/{id}"
  description = options[:description] || "Update #{klass.name} Details"
  tag = options[:tag] || klass.name.pluralize
  description_200 = options[:description_200] || 'returns data'
  check_not_aurhorized = options.fetch(:check_not_aurhorized, true)
  check_not_found = options.fetch(:check_not_found, true)

  yield if block_given?

  path url do
    let(:id) { rswag_properties[:object].id }

    put description do
      tags tag
      consumes 'application/json'

      parameters.each { |pa| parameter pa }

      response '200', description_200 do
        before do |example|
          rswag_set_schema example, action: :update
          @parameter = rswag_set_parameter(example, action: :update)
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

      it_behaves_like 'not-aurhorized' if check_not_aurhorized
      it_behaves_like 'not-found' if check_not_found
    end
  end
end

def crud_delete(options = {})
  additional_parameters = options.fetch(:additional_parameters, [])
  exclude_parameters = options.fetch(:exclude_parameters, [])
  parameters = [
    { name: :id, in: :path, type: :integer },
    { name: :authorization, in: :header, type: :string, required: true }
  ].reject { |pa| exclude_parameters.include?(pa[:name]) } + additional_parameters

  klass = options[:klass]
  slug = get_slug klass, options[:slug]
  url = options[:url] || "#{api_base_endpoint}#{slug}/{id}"
  description = options[:description] || "Delete #{klass.name}"
  tag = options[:tag] || klass.name.pluralize
  description_200 = options[:description_200] || "deleting #{klass.name} account"
  check_not_aurhorized = options.fetch(:check_not_aurhorized, true)
  check_not_found = options.fetch(:check_not_found, true)

  yield if block_given?

  path url do
    let(:id) { rswag_properties[:object].id }

    delete description do
      tags tag
      consumes 'application/json'

      parameters.each { |pa| parameter pa }

      response '200', description_200 do

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

      it_behaves_like 'not-aurhorized' if check_not_aurhorized
      it_behaves_like 'not-found' if check_not_found
    end
  end
end

def batch_update(options = {})
  additional_parameters = options.fetch(:additional_parameters, [])
  exclude_parameters = options.fetch(:exclude_parameters, [])
  parameters = [
    { name: :ids, in: :body, type: :array, items: { type: :integer } },
    { name: :authorization, in: :header, type: :string, required: true }
  ].reject { |pa| exclude_parameters.include?(pa[:name]) } + additional_parameters

  klass = options[:klass]
  slug = get_slug klass, options[:slug]
  url = options[:url] || "#{api_base_endpoint}#{get_slug klass, slug}/batch_update"
  description = options[:description] || "Batch update #{klass.name} Details"
  tag = options[:tag] || klass.name.pluralize
  description_200 = options[:description_200] || 'returns status and errors'
  check_not_aurhorized = options.fetch(:check_not_aurhorized, true)

  yield if block_given?

  path url do
    # let(:ids) { [ rswag_properties[:object].id ] }

    put description do
      tags tag
      consumes 'application/json'

      parameters.each { |pa| parameter pa }

      response '200', description_200 do

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

      it_behaves_like 'not-aurhorized' if check_not_aurhorized
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
