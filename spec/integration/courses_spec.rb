require 'swagger_helper'

describe Api::V1::CoursesController do
  let!(:course) { create :course, organization: current_user.organizations.first }
  let(:rswag_properties) { { current_user: current_user, object: course } }

  crud_index Course do
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

  crud_show Course
  crud_create Course
  crud_update Course
  crud_delete Course
end
