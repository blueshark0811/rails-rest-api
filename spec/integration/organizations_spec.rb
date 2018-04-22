require 'swagger_helper'

describe Api::V1::OrganizationsController do
  let(:organization) { create :organization }
  let(:current_user) { create :user, organization: organization, role: 'admin' }

  let!(:rswag_properties) do
    {
      current_user: current_user,
      current_organization: organization,
      object: organization
    }
  end

  options = { klass: Organization }

  crud_show options.merge(description: 'Details of Organization')
  crud_update options.merge(description: 'Update details of Organization')
  crud_delete options.merge(description: 'Delete Organization')
end
