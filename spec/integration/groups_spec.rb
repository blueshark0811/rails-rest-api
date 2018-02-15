require "swagger_helper"

describe Api::V1::GroupsController do
  let(:user) { create :user }
  let!(:group) { create :group, organization: user.organizations.first }
  let(:token) { Api::V1::ApiController.new.send :jwt, user }
  let(:Authorization){ "Bearer #{token}" }
  let(:page){ 1 }
  let(:count){ 20 }
  
  path "/api/v1/groups" do
    get "list of groups" do
      tags "Groups"
      consumes "application/json"

      parameter name: :Authorization, in: :header, type: :string, required: true
      parameter name: :page, in: :query, type: :integer, required: false
      parameter name: :count, in: :query, type: :integer, required: false

      response "200", "returns" do

        schema type: :object,
                properties: {
                  groups: {
                    type: :array,
                    items: {
                      created_at: :string,
                      description: :text,
                      id: :integer,
                      organization_id: :integer,
                      status: :string,
                      title: :string, 
                      updated_at: :string,
                      user_limit: :integer,
                      visibility: :string,
                      required: %i[id]
                    }
                  }
                },
                required: ["groups"]

        run_test!
      end
    end
  end

  path "/api/v1/groups/{id}" do
    get "Details" do
      tags "Groups"
      consumes "application/json"

      parameter name: :id, in: :path, type: :integer
      parameter name: :Authorization, in: :header, type: :string, required: true

      response "200", "returns" do
        let(:id) { group.id }

        schema type: :object,
               properties: {
                scholarship: {
                   type: :object,
                   properties: {
                    created_at: :string,
                    description: :text,
                    id: :integer,
                    organization_id: :integer,
                    status: :string,
                    title: :string, 
                    updated_at: :string,
                    user_limit: :integer,
                    visibility: :string,
                    required: %i[id]
                  }
                 }
               },
               required: ["group"]

        run_test!
      end
    end
  end
end
