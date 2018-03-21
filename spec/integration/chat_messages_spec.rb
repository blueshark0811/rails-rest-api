require 'swagger_helper'

describe Api::V1::ChatMessagesController do
  let(:chat) { create :chat, organization: current_user.organizations.first }
  let(:chat_message) { create :chat_message, chat: chat }
  let!(:rswag_properties) do {
    current_user: current_user,
    current_organization: current_user.organizations.first,
    object: chat_message
    }
  end
  let(:chat_id) { chat.id }

  options = { 
    klass: ChatMessage,
    slug: 'chats/{chat_id}/chat_messages',
    additional_parameters: [{
      name: :chat_id,
      in: :path,
      type: :integer,
      required: true
    }] 
  }
  additional_parameters = []

  crud_index options.merge(description: 'List of Chat Messages')
  crud_create options.merge(description: 'Create Chat Message')
  crud_update options.merge(description: 'Update details of Chat Message')
  crud_delete options.merge(description: 'Delete Chat Message')
end
