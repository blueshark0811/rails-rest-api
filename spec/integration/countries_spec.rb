require 'swagger_helper'

describe Api::V1::CountriesController do
  let(:country) { create :country }
  let!(:rswag_properties) do {
    current_user: current_user,
    current_organization: current_user.organizations.first,
    object: country
    }
  end

  options = { 
    klass: Country, 
    exclude_parameters: [:authorization, :organization_id],
    check_not_aurhorized: false
  }
  crud_index options.merge(description: 'List of Countries')
  crud_show options.merge(description: 'Details of Country')
end
