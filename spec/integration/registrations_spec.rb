# frozen_string_literal: true

require 'swagger_helper'
include ApiSpecHelper

describe 'Registration API' do
  let(:email) { Faker::Internet.email }
  let!(:user) { create(:user, email: email) }

  path '/api/v1/registrations' do
    post 'Sign up' do
      tags 'Sign up'
      consumes 'application/json'

      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string }
            }
          }
        }
      }

      response '201', 'user created' do
        let(:body) do
          {
            user: {
              email: Faker::Internet.email,
              password: Faker::Internet.password
            }
          }
        end

        before do |example|
          rswag_set_schema(example, action: :show,
                                    type: :object,
                                    required: %w[user],
                                    properties: { token: { type: :string, 'x-nullable': true } })
        end

        run_test! do |response|
          p response.body
        end
      end

      response '400', 'registration is fail with existing email' do
        let(:body) { { user: { email: email, password: Faker::Internet.password } } }

        schema type: :object,
               properties: {
                 errors: {
                   type: :array,
                   items: {
                     type: :object,
                     items: { email: :array }
                   }
                 }
               },
               required: ['errors']

        run_test!
      end
    end
  end
end
