require 'swagger_helper'

describe Api::V1::UsersController do
  let!(:rswag_properties) { { current_user: current_user, object: current_user } }

  crud_index User do
    let(:additional_parameters) do
      [{
        name: :group_id,
        in: :query,
        type: :integer,
        required: false,
        description: 'get users from specific group'
      }]
    end
  end

  crud_show User
  crud_update User
  crud_delete User
end
