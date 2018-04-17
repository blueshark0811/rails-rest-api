require 'swagger_helper'

# for admin
describe Api::V1::CoursesController do
  let(:organization) { create :organization }
  let(:current_user) { create :user, role: 'admin', organization: organization }
  let(:group) { create :group, organization: organization }
  let(:course) { create :course, organization: organization }
  let(:course_group) { create :course_group, course: course, group: group }
  let(:lesson) { create :lesson, course: course }

  let(:rswag_properties) do {
      current_user: current_user,
      current_organization: organization,
      object: course
    }
  end

  let!(:included_lesson_users_for_current_student){ true }
  let!(:included_lesson_users){ true }

  options = { klass: Course, tag: 'Admin - Course' }

  crud_index options.merge(
    as: :searchkick,
    additional_parameters: [{
      name: :group_id,
      in: :query,
      type: :integer,
      required: false,
      description: 'get courses from specific group'
    }, {
      name: :term,
      in: :query,
      type: :string,
      required: false,
      description: "term for searching by #{Course::SEARCH_FIELDS}"
    }, {
      name: :sort_field,
      in: :query,
      type: :string,
      required: false,
      enum: Course::SORT_FIELDS,
      description: 'field for sorting'
    }, {
      name: :sort_flag,
      in: :query,
      type: :string,
      required: false,
      enum: SORT_FLAGS,
      description: 'flag for sorting'
    }
    ]
  ) do
    Course.reindex
  end

  crud_show options
  crud_create options
  crud_update options
  crud_delete options
end
