require 'swagger_helper'

describe Api::V1::CitiesController do
  let(:city) { create :city }
  let!(:rswag_properties) do {
    current_user: current_user,
    current_organization: current_user.organizations.first,
    object: city
    }
  end

  options = { 
    klass: City,
    exclude_parameters: [:authorization, :organization_id],
    check_not_aurhorized: false
  }

  crud_index options.merge(description: 'List of Cities')
  crud_show options.merge(description: 'Details of City')
end
