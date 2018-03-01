require 'swagger_helper'

describe Api::V1::UsersController do
  let!(:rswag_properties) do { 
    current_user: current_user,
    current_organization: current_user.organizations.first,
    object: current_user
    } 
  end

  options = { klass: User }

  crud_index options do
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

  crud_show options
  crud_create options
  crud_update options
  crud_delete options
end
