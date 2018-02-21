require 'swagger_helper'
include ApiSpecHelper

describe Api::V1::GroupsController do
  let!(:group) { create :group, organization: current_user.organizations.first }
  let(:rswag_properties) { { current_user: current_user, object: group } }

  path '/api/v1/groups' do
    before { |example| rswag_set_schema example, { action: :index, type: :array } }

    get 'list of groups' do
      tags 'Groups'
      consumes 'application/json'

      parameter name: :authorization, in: :header, type: :string, required: true
      parameter name: :page, in: :query, type: :integer, required: false
      parameter name: :count, in: :query, type: :integer, required: false
      parameter( 
        name: :visibility, 
        in: :query, 
        type: :string, 
        required: false, 
        description: "Filter groups, possible values: #{Group.visibilities.values.join(', ')}"
      )
      parameter( 
        name: :status, 
        in: :query, 
        type: :string, 
        required: false, 
        description: "Filter groups, possible values: #{Group.statuses.values.join(', ')}"
      )
      parameter( 
        name: :my, 
        in: :query, 
        type: :boolean, 
        required: false, 
        description: "return user's groups"
      )

      response '200', 'returns' do
        run_test!
      end
    end
  end

  path "/api/v1/groups/{id}" do
    before { |example| rswag_set_schema example, { action: :show } }

    get 'Details' do
      tags 'Groups'
      consumes 'application/json'

      parameter name: :id, in: :path, type: :integer
      parameter name: :authorization, in: :header, type: :string, required: true

      response '200', 'returns' do
        let(:id) { group.id }

        run_test!
      end
    end
  end
end
