# require 'swagger_helper'

# describe Api::V1::CourseThreadsController do
#   let(:organization) { create :organization }
#   let(:current_user) { create :user, role: 'student', organization: organization }
#   let(:group) { create :group, organization: organization }

#   let!(:group_user) { create :group_user, user: current_user, group: group }

#   let(:course_thread) { create :course_thread, group: group, user: current_user }
#   let!(:comment) { create :comment, commentable: course_thread, user: current_user }

#   let!(:rswag_properties) do {
#     current_user: current_user,
#     current_organization: organization,
#     object: course_thread
#     }
#   end

#   let(:group_id) { group.id }

#   options = {
#     klass: CourseThread,
#     slug: 'groups/{group_id}/course_threads',
#     additional_parameters: [{
#       name: :group_id,
#       in: :path,
#       type: :integer,
#       required: true
#     }]
#   }

#   crud_index options.merge(
#     description: 'List of Group Threads',
#     additional_parameters: options[:additional_parameters] + [
#       {
#         name: :sort_field,
#         in: :query,
#         type: :string,
#         required: false,
#         enum: CourseThread::SORT_FIELDS,
#         description: 'field for sorting'
#       }, {
#         name: :sort_flag,
#         in: :query,
#         type: :string,
#         required: false,
#         enum: SORT_FLAGS,
#         description: 'flag for sorting'
#       }]
#   )
#   crud_show options.merge(description: 'Details of Group Thread')
#   crud_create options.merge(description: 'Create Group Thread')
#   crud_update options.merge(description: 'Update details of Group Thread')
#   crud_delete options.merge(description: 'Delete Group Thread')
# end
