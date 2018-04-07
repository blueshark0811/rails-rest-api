require 'swagger_helper'

describe Api::V1::TasksController do
  let(:organization) { create :organization }
  let(:current_user) { create :user, role: 'admin', organization: organization }
  let(:group) { create :group, organization: organization }
  let(:course) { create :course, organization: organization }
  let(:course_group) { create :course_group, course: course, group: group, precourse: nil }
  let(:lesson) { create :lesson, course: course }

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
    tag: 'Admin - Tasks',
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
