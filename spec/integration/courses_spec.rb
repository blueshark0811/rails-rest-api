require 'swagger_helper'

describe Api::V1::CoursesController do
  # let(:current_user){ create :user, role: 'student'}
  let(:group){ create :group, organization: current_user.organizations.first }
  let!(:group_user){ create :group_user, user: current_user, group: group }
  let!(:course) { create :course, organization: current_user.organizations.first }
  let!(:course_group) { create :course_group, course: course, group: group }
  let!(:lesson) { create :lesson, course: course }
  let!(:lesson_user) { create :lesson_user, lesson: lesson, user: current_user }
  let(:rswag_properties) do {
    current_user: current_user,
    current_organization: current_user.organizations.first,
    object: course
  }
  end
  let!(:included_lesson_users_for_current_user){ true }
  let!(:included_lesson_users){ true }

  options = { klass: Course }

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
    }, {
      name: :included_lesson_users_for_current_user,
      in: :query,
      type: :boolean,
      required: false,
      description: 'lesson_users for current user and courses will be included'
    }, {
      name: :included_lesson_users,
      in: :query,
      type: :boolean,
      required: false,
      description: 'lesson_users for courses will be included'
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
