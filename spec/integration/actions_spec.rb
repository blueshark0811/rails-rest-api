require 'swagger_helper'

describe Api::V1::ActionsController do
  let(:action) { create :action }
  let!(:rswag_properties) do {
    current_user: current_user,
    current_organization: current_user.organizations.first,
    object: action
  }
  end
  let(:course_id) { action.course.id }
  let(:lesson_id) { action.lesson_id }

  options = {
    klass: Action,
    slug: 'courses/{course_id}/lessons/{lesson_id}/actions',
    tag: 'Actions',
    additional_parameters: [{
      name: :course_id,
      in: :path,
      type: :integer,
      required: true
    }, {
      name: :lesson_id,
      in: :path,
      type: :integer,
      required: true
    }]
  }

  crud_index options.merge(description: 'List of Actions')
  crud_show options.merge(description: 'Details of Action')
  crud_create options.merge(description: 'Create Action')
  crud_update options.merge(description: 'Update details of Action')
  crud_delete options.merge(description: 'Delete Action')
end
