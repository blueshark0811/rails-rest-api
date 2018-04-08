require 'swagger_helper'

describe Api::V1::CommentsController do
  let(:organization) { create :organization }
  let(:current_user) { create :user, role: 'student', organization: organization }

  #noticeboard ->
  # let(:commentable) { create :group, organization: organization }
  ###

  #task ->
  let(:group) { create :group, organization: organization }
  let(:course) { create :course, organization: organization }
  let(:course_group) { create :course_group, course: course, group: group, precourse: nil }
  let(:lesson) { create :lesson, course: course }

  let!(:course_user) { create :course_user, user: current_user, course: course, course_group: course_group }
  let!(:group_user) { create :group_user, user: current_user, group: group }
  let!(:lesson_user) { create :lesson_user, lesson: lesson, user: current_user, course_group: course_group }
 
  let(:task) { create :task, action_type: 'question', lesson: lesson }
  ###

  let(:commentable) { task }
  let(:comment) { create :comment, commentable: commentable, user: current_user }
  let!(:rswag_properties) do {
    current_user: current_user,
    current_organization: organization,
    object: comment
    }
  end
  let(:commentable_id) { commentable.id }
  let(:commentable_type) { commentable.class.name }

  options = {
    klass: Comment,
    slug: '{commentable_type}/{commentable_id}/comments',
    additional_parameters: [
      {
        name: :commentable_id,
        in: :path,
        type: :integer,
        required: true
      }, {
        name: :commentable_type,
        in: :path,
        type: :string,
        required: true,
        enum: Comment::COMMENTABLES
      }
    ]
   }

  crud_index options.merge(
    description: 'List of Comments as tree view by default',
    additional_parameters: options[:additional_parameters]+[
      {
        name: :only_roots,
        in: :query,
        type: :boolean,
        required: false,
        description: 'returns only root comments'
      }, {
        name: :root_id,
        in: :query,
        type: :integer,
        required: false,
        description: 'returns comments under specific comment'
      }
    ]
  )

  crud_create options.merge(description: 'Create Comment')
  crud_update options.merge(description: 'Update details of Comment')
  crud_delete options.merge(description: 'Delete Comment')
end
