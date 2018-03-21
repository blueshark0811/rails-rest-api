require 'swagger_helper'

describe Api::V1::ChatsController do
  let(:chat) { create :chat, organization: current_user.organizations.first }
  let!(:rswag_properties) do {
    current_user: current_user,
    current_organization: current_user.organizations.first,
    object: chat
    }
  end

  let(:opponent){ create :user, organization: current_user.organizations.first }

  let(:opponent_id){ opponent.id }

  options = { klass: Chat }
  additional_parameters = []
  crud_show options.merge(
    description: 'Get/Create Chat with opponent',
    url: [api_base_endpoint, 'chats/with_opponent/{opponent_id}'].join,
    check_not_found: false,
    additional_parameters: [{
        name: :opponent_id,
        in: :path,
        type: :integer,
        required: true
      }]
    )

  crud_index options.merge(
    description: 'List of Chats',
    additional_parameters: additional_parameters
  )

  crud_show options.merge(description: 'Details of Chat')

  crud_update options.merge(description: 'Update details of Chat')
  crud_delete options.merge(description: 'Delete Chat')
end
