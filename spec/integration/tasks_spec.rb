require 'swagger_helper'

describe Api::V1::TasksController do
  let(:current_user) { create :user }
  let(:organization) { current_user.organizations.first }
  let(:course) { create :course, organization: organization, user: current_user }
  let(:lesson) { create :lesson, course_id: course.id, user: current_user }
  let(:course_id) { course.id }
  let(:lesson_id) { lesson.id }

  let(:task) { create :task, lesson: lesson, user: current_user }
  
  let!(:rswag_properties) do {
    current_user: current_user,
    current_organization: organization,
    object: task
  }
  end

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
