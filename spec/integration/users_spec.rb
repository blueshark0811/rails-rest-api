require 'swagger_helper'

describe Api::V1::UsersController do
  let!(:rswag_properties) do {
      current_user: current_user,
      current_organization: current_user.organizations.first,
      object: current_user
    }
  end

  options = { klass: User }

  crud_index options.merge(
    as: :searchkick,
    additional_parameters: [{
      name: :group_id,
      in: :query,
      type: :integer,
      required: false,
      description: 'get users from specific group'
    }, {
      name: :term,
      in: :query,
      type: :string,
      required: false,
      description: "term for searching by #{User::SEARCH_FIELDS}"
    }]
  )

  crud_show options
  crud_create options
  crud_update options
  crud_delete options

  path "#{api_base_endpoint}users/{id}/send_set_password_link" do
    let(:id) { rswag_properties[:object].id }

    post 'Send set password link to user' do
      tags 'Users'
      consumes 'application/json'

      parameter name: :id, in: :path, type: :integer
      parameter name: :authorization, in: :header, type: :string, required: true

      response '200', 'returns result' do
        schema type: :object,
               properties: {
                 success: { type: :boolean }
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
