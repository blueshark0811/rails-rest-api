require 'swagger_helper'

# for students and teachers
describe Api::V1::CoursesController do
  let(:organization) { create :organization }
  let(:student) { create :user, role: 'student', organization: organization }
  let(:teacher) { create :user, role: 'teacher', organization: organization }

  let(:current_user) { teacher }
  let(:group) { create :group, organization: organization }
  let(:course) { create :course, organization: organization }
  let(:course_group) { create :course_group, course: course, group: group, precourse: nil }
  let(:lesson) { create :lesson, course: course }

  let!(:course_user) { create :course_user, user: student, course: course, course_group: course_group, position: 2 }
  let!(:group_user) { create :group_user, user: student, group: group }
  let!(:group_user_teacher) { create :group_user, user: teacher, group: group }
  let!(:lesson_user) { create :lesson_user, lesson: lesson, user: student, course_group: course_group }

  # check ordering at index action
  let(:course2) { create :course, organization: organization }
  let(:course_group2) { create :course_group, course: course2, group: group, precourse: nil }
  let!(:course_user2) { create :course_user, user: student, course: course2, course_group: course_group2, position: 1 }
  ###

  let(:rswag_properties) do {
    current_user: current_user,
    current_organization: organization,
    object: course
  }
  end
  let!(:included_lesson_users_for_current_student){ true }
  let!(:included_lesson_users){ true }
  let(:group_id) { group.id }
  let(:student_id) { student.id }

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
      name: :included_lesson_users_for_current_student,
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
    }, {
      name: :student_id,
      in: :query,
      type: :integer,
      required: false,
      description: 'teacher could see courses of specific student'
    }
    ]
  ) do
    Course.reindex
  end

  crud_show options

  path "#{api_base_endpoint}#{options[:slug]}/{id}/switch" do
    let(:id) { rswag_properties[:object].id }
    let(:active) { false }
    let(:current_user) { teacher }
    let(:student_id) { student.id }

    put 'Activate/Diactivate course for student' do
      tags 'Courses'
      consumes 'application/json'

      parameter name: :id, in: :path, type: :integer
      parameter name: :authorization, in: :header, type: :string, required: true
      parameter(
        name: :active,
        in: :query,
        type: :boolean,
        required: true
      )

      parameter(
        name: :student_id,
        in: :query,
        type: :integer,
        required: false
      )

      options[:additional_parameters].each do |attrs|
        parameter attrs
      end

      response '200', 'returns result' do
        schema type: :object,
               properties: {
                 success: { type: :boolean }
               },
               required: ['success']

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['success']).to eq true
        end
      end
    end
  end
end
