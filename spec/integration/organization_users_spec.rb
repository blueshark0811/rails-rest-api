require 'swagger_helper'

describe Api::V1::OrganizationUsersController do
  let(:organization) { create :organization }
  let(:current_user) { create :user, organization: organization }
  let(:organization_user) { current_user.organization_users.first }
  let!(:rswag_properties) do
    {
      current_user: current_user,
      current_organization: organization,
      object: organization_user
    }
  end

  # let(:organization_id) { organization.id }

  options = {
    klass: OrganizationUser,
    # slug: 'organizations/{organization_id}/organization_users',
    # additional_parameters: [{
    #   name: :organization_id,
    #   in: :path,
    #   type: :integer,
    #   required: true
    # }]
  }

  crud_create options.merge(description: 'Create OrganizationUser')
  crud_delete options.merge(description: 'Delete OrganizationUser')
end
