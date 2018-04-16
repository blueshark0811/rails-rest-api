require 'swagger_helper'

describe Api::V1::ActivitiesController do
  let(:organization) { create :organization }
  let(:current_user) { create :user, role: 'teacher', organization: organization }
  let(:student) { create :user, role: 'student', organization: organization }

  let(:group) { create :group, organization: organization }
  let(:course) { create :course, organization: organization }
  let(:course_group) { create :course_group, course: course, group: group, precourse: nil }
  let(:lesson) { create :lesson, course: course }

  let!(:course_user) { create :course_user, user: student, course: course, course_group: course_group }
  let!(:group_user) { create :group_user, user: student, group: group }
  let!(:lesson_user) { create :lesson_user, lesson: lesson, user: student, course_group: course_group }

  let(:task) { create :task, lesson: lesson, user: current_user }
  let!(:task_user) { create :task_user, task: task, user: student, course_group: course_group }

  let(:comment) { create :comment, commentable: task_user }

  let(:notifiable) { current_user }

  let(:activity) do 
    create(:activity,
      notifiable: notifiable,
      user: student,
      task: task,
      lesson: lesson,
      course: course,
      group: group,
      teacher_ids: [current_user.id]
    )
  end

  let!(:rswag_properties) do {
    current_user: current_user,
    current_organization: organization,
    object: activity
    }
  end
  let(:notifiable_id) { notifiable.id }
  let(:notifiable_type) { notifiable.class.name }

  options = {
    klass: Activity,
    slug: '{notifiable_type}/{notifiable_id}/activities',
    additional_parameters: [{
      name: :notifiable_id,
      in: :path,
      type: :integer,
      required: true
    }, {
      name: :notifiable_type,
      in: :path,
      type: :string,
      required: true,
      enum: Activity::NOTIFIABLES
    }, {
      name: :flagged,
      in: :query,
      type: :boolean,
      required: false
    }, {
      name: :status,
      in: :query,
      type: :string,
      required: false,
      enum: Activity.statuses.values,
      description: 'Filter activities by status'
    }, {
      name: :user_id,
      in: :query,
      type: :integer,
      required: false,
      description: 'Filter activities by person who created it'
    }, {
      name: :lesson_id,
      in: :query,
      type: :integer,
      required: false,
      description: 'Filter activities by lesson'
    }, {
      name: :course_id,
      in: :query,
      type: :integer,
      required: false,
      description: 'Filter activities by course'
    }, {
      name: :sort_field,
      in: :query,
      type: :string,
      required: false,
      enum: Activity::SORT_FIELDS,
      description: 'field for sorting'
    }, {
      name: :sort_flag,
      in: :query,
      type: :string,
      required: false,
      enum: SORT_FLAGS,
      description: 'flag for sorting'
    }]
  }

  crud_index options.merge(description: 'Activities')
  crud_update options.merge(description: 'Update status of Activity')
  crud_delete options.merge(description: 'Delete Activity')
end
