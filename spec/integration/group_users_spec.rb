# frozen_string_literal: true

require 'swagger_helper'

describe Api::V1::GroupUsersController do
  let(:organization) { create :organization }
  let(:current_user) { create :user, organization: organization, role: 'admin' }
  let(:group) { create :group, :reindex, organization: organization }
  let!(:group_current_user) { create :group_user, :reindex, group: group, user: current_user }
  let(:group_user) { create :group_user, :reindex, group: group, user: create(:user) }
  let!(:rswag_properties) do {
    current_user: current_user,
    current_organization: organization,
    object: group_user
    }
  end
  let!(:group_id) { group.id }
  let(:current_user_id) { current_user.id }

  options = {
    klass: GroupUser,
    slug: 'groups/{group_id}/group_users',
    tag: 'Users vs Groups',
    additional_parameters: [{
      name: :group_id,
      in: :path,
      type: :integer,
      required: true
    }]
  }

  crud_index options.merge(
    as: :searchkick,
    description: 'Users in group',
    additional_parameters: options[:additional_parameters] + [
    {
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

  opt = { description: 'Add User to group', additional_body: { group_user: { user_id: '{:current_user_id}' } } }
  crud_create options.merge(opt) do
    GroupUser.delete_all
  end

  crud_update options.merge(description: 'Change status of user in group')
  crud_delete options.merge(description: 'Delete user from group')

  let(:ids) { [group.id] }
  let(:status) { GroupUser.statuses.keys.first }

  batch_update options.merge(
    description: 'Change status of batch users in group',
    additional_parameters: options[:additional_parameters] + [
    {
      name: :status,
      in: :body,
      type: :string,
      enum: GroupUser.statuses.keys,
      required: true
    }]
  )
end
