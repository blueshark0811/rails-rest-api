require 'swagger_helper'

describe Api::V1::StatesController do
  let(:state) { create :state }
  let!(:rswag_properties) do {
    current_user: current_user,
    current_organization: current_user.organizations.first,
    object: state
    }
  end

  options = { 
    klass: State,
    exclude_parameters: [:authorization, :organization_id],
    check_not_aurhorized: false
  }

  crud_index options.merge( description: 'List of States')
  crud_show options.merge(description: 'Details of State')
end
