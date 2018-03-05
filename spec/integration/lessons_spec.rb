# frozen_string_literal: true

require 'swagger_helper'

describe Api::V1::LessonsController do
  let!(:course) { create :course, organization: current_user.organizations.first }
  let!(:lesson) { create :lesson, course: course, user: current_user }
  let(:rswag_properties) { { current_user: current_user, object: lesson } }
  let!(:course_id) { course.id }

  options = { klass: GroupUser, slug: 'courses/{course_id}/lessons', tag: 'Lessons' }

  additional_params = [{
    name: :course_id,
    in: :path,
    type: :integer,
    required: true
  }]

  crud_index options.merge(description: 'Lessons for course') do
    let(:additional_parameters) { additional_params }
  end

  crud_create options.merge(description: 'Add lesson to course') do
    let(:additional_parameters) { additional_params }
  end

  crud_update options.merge(description: 'Update attributes of lesson') do
    let(:additional_parameters) { additional_params }
  end

  crud_delete options.merge(description: 'Delete lesson') do
    let(:additional_parameters) { additional_params }
  end
end
