# frozen_string_literal: true

require 'swagger_helper'

describe Api::V1::AttachmentsController do
  let(:current_user) { create :user }
  let!(:attachmentable) { current_user.organizations.first }
  let!(:attachment) do
    create :attachment,
      :reindex,
      attachmentable: attachmentable,
      user: current_user,
      organization: attachmentable
  end
  let(:rswag_properties) do {
    current_user: current_user,
    current_organization: current_user.organizations.first,
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
