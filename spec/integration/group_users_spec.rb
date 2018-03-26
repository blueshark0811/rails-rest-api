# frozen_string_literal: true

require 'swagger_helper'

describe Api::V1::GroupUsersController do
  let!(:group) { create :group, :reindex, organization: current_user.organizations.first }
  let!(:group_user) { create :group_user, :reindex, group: group, user: current_user }
  let(:rswag_properties) do {
    current_user: current_user,
    current_organization: current_user.organizations.first,
    object: group_user
    }
  end
  let!(:group_id) { group.id }

  options = { 
    klass: GroupUser, 
    slug: 'groups/{group_id}/group_users', 
    tag: 'Users vs Groups'
  }

  crud_index options.merge(
    as: :searchkick, 
    description: 'Users in group',
    additional_parameters: [{
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
      name: :sort_flag,
      in: :query,
      type: :string,
      required: false,
      enum: SORT_FLAGS,
      description: 'flag for sorting'
    }]
  )

  crud_create options.merge(
    description: 'Add User to group',
    additional_parameters: [{
      name: :group_id,
      in: :path,
      type: :integer,
      required: true
    }]
  )

  crud_update options.merge(
    description: 'Change status of user in group',
    additional_parameters: [{
      name: :group_id,
      in: :path,
      type: :integer,
      required: true
    }]
  )

  crud_delete options.merge(
    description: 'Delete user from group',
    additional_parameters: [{
      name: :group_id,
      in: :path,
      type: :integer,
      required: true
    }]
   )

  batch_update options.merge(
    description: 'Change status of batch users in group',
    additional_parameters: [{
      name: :group_id,
      in: :path,
      type: :integer,
      required: true
    }, {
      name: :status,
      in: :body,
      type: :string,
      enum: GroupUser.statuses.keys,
      required: true
    }]
  ) do
     let(:ids) { [group.id] }
     let(:status) { GroupUser.statuses.keys.first }
  end
end
