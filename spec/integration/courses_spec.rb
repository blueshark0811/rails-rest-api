require 'swagger_helper'
include ApiSpecHelper

describe Api::V1::CoursesController do
  let!(:course) { create :course, organization: current_user.organizations.first }
  let(:rswag_properties) { { current_user: current_user, object: course } }

  CURRENT_CLASS = Course #need for description of actions

  it_behaves_like 'crud-index' do
    let(:additional_parameters) do
      [{
        name: :group_id,
        in: :query,
        type: :integer,
        required: false,
        description: "get courses from specific group"
      }]
    end
  end

  it_behaves_like 'crud-show'

  it_behaves_like 'crud-update'

  it_behaves_like 'crud-delete'
end
