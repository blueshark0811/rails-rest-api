# frozen_string_literal: true

require 'swagger_helper'

describe Api::V1::LessonsController do
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
    current_organization: organization,
    object: lesson
  }
  end
  let!(:course_id) { course.id }
  let!(:group_id) { group.id }
  let!(:included_lesson_users_for_current_user){ true }

  options = {
    klass: Lesson,
    slug: 'groups/{group_id}/courses/{course_id}/lessons',
    tag: 'Lessons',
    additional_parameters: [{
      name: :course_id,
      in: :path,
      type: :integer,
      required: true
    }, {
      name: :group_id,
      in: :path,
      type: :integer,
      required: true
    }]
  }

  crud_index options.merge(description: 'Lessons for course')
  crud_show options.merge(description: 'Get info about lesson at specific course',
    additional_parameters: options[:additional_parameters] + [
    {
      name: :included_lesson_users_for_current_user,
      in: :query,
      type: :boolean,
      required: false,
      description: 'lesson_users for current user and courses will be included inside course instance in meta section'
    }]
  )
end
