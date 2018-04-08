# frozen_string_literal: true

require 'swagger_helper'

describe Api::V1::AttachmentsController do
  let(:organization) { create :organization }
  let(:current_user) { create :user, role: :student, organization: organization }
  # let(:current_user) { create :user, role: :admin }
  # let(:current_user) { create :user, role: :student }
  # let!(:attachmentable) { create :course, organization: organization }
  # let(:attachmentable) { create :chat_message, chat: create(:chat, organization: organization) }

  #task ->
  let(:group) { create :group, organization: organization }
  let(:course) { create :course, organization: organization }
  let(:course_group) { create :course_group, course: course, group: group, precourse: nil }
  let(:lesson) { create :lesson, course: course }

  let!(:course_user) { create :course_user, user: current_user, course: course, course_group: course_group }
  let!(:group_user) { create :group_user, user: current_user, group: group }
  let!(:lesson_user) { create :lesson_user, lesson: lesson, user: current_user, course_group: course_group }

  let(:task) { create :task, action_type: 'question', lesson: lesson }
  let(:attachmentable) { task }
  ###

  let!(:attachment) do
    create :attachment,
      :reindex,
      attachmentable: attachmentable,
      user: current_user,
      organization: organization
  end
  let(:rswag_properties) do {
    current_user: current_user,
    current_organization: organization,
    object: attachment
    }
  end
  let!(:attachmentable_id) { attachmentable.id }
  let(:attachmentable_type) { attachmentable.class.name }

  options = {
    klass: Attachment,
    slug: '{attachmentable_type}/{attachmentable_id}/attachments',
    tag: 'Attachments',
    additional_parameters: [{
      name: :attachmentable_id,
      in: :path,
      type: :integer,
      required: true
    }, {
      name: :attachmentable_type,
      in: :path,
      type: :string,
      required: true,
      enum: Attachment::ATTACHMENTABLES
    }]
  }

  additional_body = {
    attachment: {
      data: FakeFile.file
    }
  }

  crud_index options.merge(
    description: 'Attachments',
    as: :searchkick,
    additional_parameters: options[:additional_parameters] +
    [{
      name: :term,
      in: :query,
      type: :string,
      required: false,
      description: "term for searching by #{Attachment::SEARCH_FIELDS}"
    }, {
      name: :sort_field,
      in: :query,
      type: :string,
      required: false,
      enum: Attachment::SORT_FIELDS,
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
  crud_create options.merge(description: 'Add Attachment', additional_body: additional_body)
  crud_update options.merge(description: 'Update Attachment')
  crud_delete options.merge(description: 'Delete Attachment')
end
