# frozen_string_literal: true

require 'swagger_helper'

describe Api::V1::AttachmentsController do
  let!(:attachmentable) { current_user.organizations.first }
  let!(:attachment) { create :attachment, attachmentable: attachmentable, user: current_user, organization: attachmentable }
  let(:rswag_properties) { { current_user: current_user, object: attachment } }
  let!(:attachmentable_id) { attachmentable.id }
  let(:attachmentable_type) { attachmentable.class.name }

  options = { 
    klass: Attachment,
    slug: '{attachmentable_type}/{attachmentable_id}/attachments',
    tag: 'Attachments'
  }

  additional_params = [{
    name: :attachmentable_id,
    in: :path,
    type: :integer,
    required: true
  },{
    name: :attachmentable_type,
    in: :path,
    type: :string,
    required: true
  }]

  crud_index options.merge(description: 'Attachments') do
    let(:additional_parameters) { additional_params }
  end

  crud_create options.merge(description: 'Add Attachment') do
    let(:additional_parameters) { additional_params }
  end

  crud_update options.merge(description: 'Update Attachment') do
    let(:additional_parameters) { additional_params }
  end

  crud_delete options.merge(description: 'Delete Attachment') do
    let(:additional_parameters) { additional_params }
  end
end
