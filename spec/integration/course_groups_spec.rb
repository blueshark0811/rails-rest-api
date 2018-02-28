# frozen_string_literal: true

require 'swagger_helper'

describe Api::V1::CourseGroupsController do
  let!(:group) { create :group, organization: current_user.organizations.first }
  let!(:course) { create :course, organization: current_user.organizations.first }
  let!(:course_group) { create :course_group, group: group, course: course }
  let(:rswag_properties) { { current_user: current_user, object: course_group } }
  let!(:group_id) { group.id }

  options = { klass: CourseGroup, slug: 'groups/{group_id}/course_groups' }

  crud_create options.merge(description: 'Add Course to group', tag: 'Courses') do
    let(:additional_parameters) do
      [{
        name: :group_id,
        in: :path,
        type: :integer,
        required: true
      }]
    end
  end

  crud_update options.merge(description: 'Update Course in group', tag: 'Courses') do
    let(:additional_parameters) do
      [{
        name: :group_id,
        in: :path,
        type: :integer,
        required: true
      }]
    end
  end

  crud_delete options.merge(description: 'Delete Course from group', tag: 'Courses') do
    let(:additional_parameters) do
      [{
        name: :group_id,
        in: :path,
        type: :integer,
        required: true
      }]
    end
  end
end
