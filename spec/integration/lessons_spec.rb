# frozen_string_literal: true

require 'swagger_helper'

describe Api::V1::LessonsController do
  let!(:course) { create :course, organization: current_user.organizations.first }
  let!(:lesson) { create :lesson, course: course, user: current_user }
  let(:rswag_properties) { { current_user: current_user, object: lesson } }
  let!(:course_id) { course.id }

  options = {
    klass: Lesson,
    slug: 'courses/{course_id}/lessons',
    tag: 'Lessons',
    additional_parameters: [{
      name: :course_id,
      in: :path,
      type: :integer,
      required: true
    }]
  }

  crud_index options.merge(description: 'Lessons for course')
  crud_create options.merge(description: 'Add lesson to course') 
  crud_update options.merge(description: 'Update attributes of lesson')
  crud_delete options.merge(description: 'Delete lesson')
end
