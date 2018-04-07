require 'swagger_helper'

# for students and teachers
describe Api::V1::CoursesController do
  let(:organization) { create :organization }
  let(:current_user) { create :user, role: 'student', organization: organization }
  let(:group) { create :group, organization: organization }
  let(:course) { create :course, organization: organization }
  let(:course_group) { create :course_group, course: course, group: group, precourse: nil }
  let(:lesson) { create :lesson, course: course }

  let!(:course_user) { create :course_user, user: current_user, course: course, course_group: course_group }
  let!(:group_user) { create :group_user, user: current_user, group: group }
  let!(:lesson_user) { create :lesson_user, lesson: lesson, user: current_user, course_group: course_group }

  let(:rswag_properties) do {
    current_user: current_user,
    current_organization: current_user.organizations.first,
    object: course
  }
  end
  let!(:included_lesson_users_for_current_user){ true }
  let!(:included_lesson_users){ true }
  let(:group_id) { group.id }

  options = {
    klass: Course,
    slug: 'groups/{group_id}/courses',
    additional_parameters: [{
      name: :group_id,
      in: :path,
      type: :integer,
      required: true
    }]
  }

  crud_index options.merge(
    as: :searchkick,
    additional_parameters: options[:additional_parameters] +[{
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
end
