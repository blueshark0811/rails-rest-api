# frozen_string_literal: true

require 'swagger_helper'

describe Api::V1::AttachmentsController do
  let!(:attachmentable) { current_user.organizations.first }
  let!(:attachment) {
    create :attachment,
      attachmentable: attachmentable,
      user: current_user,
      organization: attachmentable
  }
  let(:rswag_properties) { { current_user: current_user, object: attachment } }
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

  crud_index options.merge(description: 'Attachments')
  crud_create options.merge(description: 'Add Attachment', additional_body: additional_body)
  crud_update options.merge(description: 'Update Attachment')
  crud_delete options.merge(description: 'Delete Attachment')
end