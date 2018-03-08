require 'swagger_helper'

describe Api::V1::CoursesController do
  let!(:course) { create :course, organization: current_user.organizations.first }
  let(:rswag_properties) { { current_user: current_user, object: course } }

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
    }]
  )

  crud_show options
  crud_create options
  crud_update options
  crud_delete options
end
