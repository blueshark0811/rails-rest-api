require 'swagger_helper'
include ApiSpecHelper

describe Api::V1::UsersController do
  let!(:user) { create :user }

  let(:rswag_properties) { { current_user: current_user, object: user } }

  path '/api/v1/users' do
    before { |example| rswag_set_schema example, { action: :index, type: :array } }

    get 'Users list inside organization' do
      tags 'Users'
      consumes 'application/json'

      parameter name: :authorization, in: :header, type: :string, required: true
      parameter name: :current_page, in: :query, type: :integer, required: false
      parameter name: :current_count, in: :query, type: :integer, required: false

      response '200', 'return data' do
        run_test!
      end
    end
  end

  path "/api/v1/users/{id}" do
    let(:id) { user.id }

    get 'Users info' do
      before { |example| rswag_set_schema example, { action: :show } }

      tags 'Users'
      consumes 'application/json'

      parameter name: :id, in: :path, type: :integer
      parameter name: :authorization, in: :header, type: :string, required: true

      response '200', 'information about User' do
        run_test!
      end
    end

    put 'Update User Details' do
      before do |example|
        rswag_set_schema example, { action: :update }
        rswag_set_parameter example, action: :update
      end

      tags 'Users'
      consumes 'application/json'

      parameter name: :id, in: :path, type: :integer
      parameter name: :authorization, in: :header, type: :string, required: true

      response '200', 'return data' do
        let(:body) { { user: build(:user).attributes.select{|k,v| !v.nil?} } }

        run_test!
      end
    end
  end
end
