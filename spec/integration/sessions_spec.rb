require "swagger_helper"

describe Api::V1::SessionsController do
  let(:email) { Faker::Internet.email }
  let!(:user) { create :user, email: email, password: email }
  let(:token) { Api::V1::ApiController.new.send :jwt, user }

  path "/api/v1/sessions" do
    delete "Destroy a session" do
      tags "Session"
      consumes "application/json"

      parameter name: :Authorization, in: :header, type: :string, required: true

      response "200", "session destroyed" do
        let(:Authorization){ "Bearer #{token}"}

        schema type: :object,
               properties: {
                 success: { type: :boolean, value: true }
               },
               required: ["success"]

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['success']).to eq true
        end
      end
    end

    post "Create a session" do
      tags "Session"
      consumes "application/json"

      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        }
      }

      response "201", "session created" do
        let(:body) { { email: email, password: email } }

        schema type: :object,
               properties: {
                 user: { type: :object },
                 token: { type: :string }
               },
               required: %w[user token]

        run_test!
      end

      response "401", "session is fail with wrong password" do
        let(:body) { { email: email, password: "wrong" } }

        schema type: :object,
          properties: {
            errors: { 
              type: :array,
              items: { 
                type: :string
              } 
            }
          },
          required: [ 'errors' ]

        run_test!
      end

      response "401", "session is fail with wrong email" do
        let(:body) { { email: "wrong", password: email } }

        schema type: :object,
          properties: {
            errors: { 
              type: :array,
              items: { 
                type: :string
              } 
            }
          },
          required: [ 'errors' ]

        run_test!
      end

      response "400", "session is fail if user is not confirmed" do
        let(:new_email) { Faker::Internet.email } 
        let!(:user_not_confrimed) { create :user, email: new_email, password: new_email, confirmed_at: nil }
        
        let(:body) { { email: new_email, password: new_email } }

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
          required: [ 'errors' ]
        
        run_test!
      end
    end
  end
end
