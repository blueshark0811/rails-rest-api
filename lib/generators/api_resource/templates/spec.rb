require 'swagger_helper'

describe Api::V1::<%= class_name.pluralize %>Controller do
  let(:<%= singular_name %>) { create :<%= singular_name %> }
  let!(:rswag_properties) do {
    current_user: current_user,
    current_organization: current_user.organizations.first,
    object: <%= singular_name %>
    }
  end

  options = { klass: <%= class_name %> }
  additional_parameters = []

  crud_index options.merge(
    description: 'List of <%= class_name.pluralize %>',
    additional_parameters: additional_parameters
  )
  crud_show options.merge(description: 'Details of <%= class_name %>')
  crud_create options.merge(description: 'Create <%= class_name %>')
  crud_update options.merge(description: 'Update details of <%= class_name %>')
  crud_delete options.merge(description: 'Delete <%= class_name %>')
end
