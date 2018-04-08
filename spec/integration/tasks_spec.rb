require 'swagger_helper'
#for students and teachers
describe Api::V1::TasksController do
  let(:organization) { create :organization }
  let(:current_user) { create :user, role: 'student', organization: organization }
  let(:group) { create :group, organization: organization }
  let(:course) { create :course, organization: organization }
  let(:course_group) { create :course_group, course: course, group: group, precourse: nil }
  let(:lesson) { create :lesson, course: course }

  let!(:course_user) { create :course_user, user: current_user, course: course, course_group: course_group }
  let!(:group_user) { create :group_user, user: current_user, group: group }
  let!(:lesson_user) { create :lesson_user, lesson: lesson, user: current_user, course_group: course_group }
  
  let(:task) { create :task, lesson: lesson, user: current_user }

  let(:group_id) { group.id }
  let(:course_id) { course.id }
  let(:lesson_id) { lesson.id }

  let!(:rswag_properties) do {
    current_user: current_user,
    current_organization: organization,
    object: task
    }
  end

  options = {
    klass: Task,
    slug: 'groups/{group_id}/courses/{course_id}/lessons/{lesson_id}/tasks',
    tag: 'Tasks',
    additional_parameters: [{
      name: :group_id,
      in: :path,
      type: :integer,
      required: true
    }, {
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
end
