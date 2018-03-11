require 'swagger_helper'

describe Api::V1::TasksController do
  let(:task) { create :task }
  let!(:rswag_properties) do {
    current_user: current_user,
    current_organization: current_user.organizations.first,
    object: task
  }
  end
  let(:course_id) { task.course.id }
  let(:lesson_id) { task.lesson_id }

  options = {
    klass: Task,
    slug: 'courses/{course_id}/lessons/{lesson_id}/tasks',
    tag: 'Tasks',
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

  crud_index options.merge(description: 'List of Tasks')
  crud_show options.merge(description: 'Details of Task')
  crud_create options.merge(description: 'Create Task')
  crud_update options.merge(description: 'Update details of Task')
  crud_delete options.merge(description: 'Delete Task')
end
