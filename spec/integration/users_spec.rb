require 'swagger_helper'
include ApiSpecHelper

describe Api::V1::UsersController do
  let!(:rswag_properties) { { current_user: current_user, object: current_user } }
  CURRENT_CLASS = User #need for description of actions
  it_behaves_like 'crud-index' do
    let(:additional_parameters) do
      [{
        name: :group_id,
        in: :query,
        type: :integer,
        required: false,
        description: "get users from specific group"
      }]
    end
  end

  it_behaves_like 'crud-show'

  it_behaves_like 'crud-update'

  it_behaves_like 'crud-delete'
end
