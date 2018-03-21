require 'swagger_helper'

describe Api::V1::SessionsController do
  let!(:user) { create :user }

  path '/api/v1/passwords' do
    post 'Send reset password token' do
      tags 'Passwords'
      consumes 'application/json'

      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string, description: "user's email or id required" },
          id: { type: :integer, description: "user's email or id required" }
        }
      }

      response '200', '' do
        let(:body) { { email: user.email } }

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
    end

    put 'Update password' do
      tags 'Passwords'
      consumes 'application/json'

      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          password: { type: :string },
          password_confirmation: { type: :string },
          reset_password_token: { type: :string }
        }
      }

      response '201', 'password changed' do
        let(:body) do {
          password: '123456abc',
          password_confirmation: '123456abc',
          reset_password_token: user.send(:set_reset_password_token)
          }
        end

        before do |example|
          rswag_set_schema(example, {
            action: :show,
            type: :object,
            required: ['user', 'token'],
            properties: { token: { type: :string, 'x-nullable': true } }
          })
        end

        run_test!
      end

      response '400', 'fail with wrong token' do
        let(:body) do {
          password: '123456abc',
          password_confirmation: '123456abc',
          reset_password_token: 'wrong'
          }
        end

        schema type: :object,
          properties: {
            errors: {
              type: :array,
              items: {
                type: :string
              }
            }
          },
          required: ['errors']

        run_test!
      end
    end
  end
end
