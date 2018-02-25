# frozen_string_literal: true

require 'swagger_helper'
include ApiSpecHelper

def current_slug
  "groups/{group_id}/group_users"
end

describe Api::V1::GroupUsersController do
  let!(:group) { create :group, organization: current_user.organizations.first }
  let!(:group_user) { create :group_user, group: group, user: current_user }
  let(:rswag_properties) { { current_user: current_user, object: group_user } }
  let(:group_id) { group.id }

  CURRENT_CLASS = GroupUser # need for description of actions

  it_behaves_like 'crud-index' do
    let(:additional_parameters) do
      [{
        name: :group_id,
        in: :path,
        type: :integer,
        required: true
      },{
        name: :sort_field,
        in: :query,
        type: :string,
        required: false,
        enum: GroupUser::SORT_FIELDS,
        description: "field for sorting"
      }, {
        name: :status,
        in: :query,
        type: :string,
        required: false,
        enum: SORT_FLAGS,
        description: "flag for sorting"
      }]
    end
  end

  # it_behaves_like 'crud-update'

  # it_behaves_like 'crud-delete'
end
