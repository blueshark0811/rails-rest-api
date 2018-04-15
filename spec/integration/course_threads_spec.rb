require 'swagger_helper'

describe Api::V1::CourseThreadsController do
  let(:organization) { create :organization }
  let(:current_user) { create :user, role: 'student', organization: organization }
  let(:group) { create :group, organization: organization }
  let(:course) { create :course, organization: organization }

  let(:course_group) { create :course_group, course: course, group: group, precourse: nil }

  let!(:group_user) { create :group_user, user: current_user, group: group }
  let!(:course_user) { create :course_user, user: current_user, course: course, course_group: course_group }

  let(:course_thread) { create :course_thread, course_group: course_group, user: current_user }
  let!(:comment) { create :comment, commentable: course_thread, user: current_user }

  let!(:rswag_properties) do {
    current_user: current_user,
    current_organization: organization,
    object: course_thread
    }
  end

  let(:group_id) { group.id }
  let(:course_id) { course.id }

  options = {
    klass: CourseThread,
    slug: 'groups/{group_id}/courses/{course_id}/course_threads',
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
    }]
  }

  crud_index options.merge(
    description: 'List of Course Threads',
    additional_parameters: options[:additional_parameters] + [
      {
        name: :sort_field,
        in: :query,
        type: :string,
        required: false,
        enum: CourseThread::SORT_FIELDS,
        description: 'field for sorting'
      }, {
        name: :sort_flag,
        in: :query,
        type: :string,
        required: false,
        enum: SORT_FLAGS,
        description: 'flag for sorting'
      }]
  )
  crud_show options.merge(description: 'Details of Course Thread')
  crud_create options.merge(description: 'Create Course Thread')
  crud_update options.merge(description: 'Update details of Course Thread')
  crud_delete options.merge(description: 'Delete Course Thread')
end
