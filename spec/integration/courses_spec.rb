require 'swagger_helper'

describe Api::V1::CoursesController do
  let!(:course) { create :course, organization: current_user.organizations.first }
  let(:rswag_properties) { { current_user: current_user, object: course } }

  options = { klass: Course }

  crud_index options do
    let(:additional_parameters) do
      [{
        name: :group_id,
        in: :query,
        type: :integer,
        required: false,
        description: 'get courses from specific group'
      }]
    end
  end

  crud_show options
  crud_create options
  crud_update options
  crud_delete options
end
