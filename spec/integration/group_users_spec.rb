# frozen_string_literal: true

require 'swagger_helper'

describe Api::V1::GroupUsersController do
  let!(:group) { create :group, organization: current_user.organizations.first }
  let!(:group_user) { create :group_user, group: group, user: current_user }
  let(:rswag_properties) { { current_user: current_user, object: group_user } }
  let!(:group_id) { group.id }

  crud_index GroupUser, 'groups/{group_id}/group_users', :searchkick do
    let(:additional_parameters) do
      [{
        name: :group_id,
        in: :path,
        type: :integer,
        required: true
      }, {
        name: :sort_field,
        in: :query,
        type: :string,
        required: false,
        enum: GroupUser::SORT_FIELDS,
        description: 'field for sorting'
      }, {
        name: :status,
        in: :query,
        type: :string,
        required: false,
        enum: SORT_FLAGS,
        description: 'flag for sorting'
      }]
    end
  end

  crud_create GroupUser, 'groups/{group_id}/group_users' do
    let(:user_id) { current_user.id }
    let(:additional_parameters) do
      [{
        name: :group_id,
        in: :path,
        type: :integer,
        required: true
      },{
        name: :user_id,
        in: :body,
        type: :integer,
        required: true
      }]
    end
  end

  crud_update GroupUser, 'groups/{group_id}/group_users' do
    let(:additional_parameters) do
      [{
        name: :group_id,
        in: :path,
        type: :integer,
        required: true
      }]
    end
  end

  crud_delete GroupUser, 'groups/{group_id}/group_users' do
    let(:additional_parameters) do
      [{
        name: :group_id,
        in: :path,
        type: :integer,
        required: true
      }]
    end
  end

  batch_update GroupUser, 'groups/{group_id}/group_users' do
    let(:ids){ [group.id] }
    let(:status){ GroupUser.statuses.keys.first }

    let(:additional_parameters) do
      [{
        name: :group_id,
        in: :path,
        type: :integer,
        required: true
      },{
        name: :status,
        in: :body,
        type: :string,
        enum: GroupUser.statuses.keys,
        required: true
      }]
    end
  end
end
