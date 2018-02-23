# frozen_string_literal: true

require 'swagger_helper'
include ApiSpecHelper

describe Api::V1::GroupsController do
  let!(:group) { create :group, organization: current_user.organizations.first }
  let(:rswag_properties) { { current_user: current_user, object: group } }

  CURRENT_CLASS = Group # need for description of actions

  it_behaves_like 'crud-index' do
    let(:additional_parameters) do
      [{
        name: :visibility,
        in: :query,
        type: :string,
        required: false,
        enum: Group.visibilities.values,
        description: "Filter groups by visibility"
      }, {
        name: :status,
        in: :query,
        type: :string,
        required: false,
        enum: Group.statuses.values,
        description: "Filter groups by status"
      }, {
        name: :my,
        in: :query,
        type: :boolean,
        required: false,
        description: "return user's groups"
      }]
    end
  end

  it_behaves_like 'crud-show'

  it_behaves_like 'crud-update'

  it_behaves_like 'crud-delete'
end
