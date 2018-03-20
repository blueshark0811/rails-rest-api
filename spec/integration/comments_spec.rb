require 'swagger_helper'

describe Api::V1::CommentsController do
  let(:commentable) { create :group, organization: current_user.organizations.first }
  let(:comment) { create :comment, commentable: commentable }
  let!(:rswag_properties) do {
    current_user: current_user,
    current_organization: current_user.organizations.first,
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
