class ChatMessageJob < ApplicationJob
  queue_as :important

  def perform(chat_message)
    ActionCable.server.broadcast(
      Chat.channel(chat_message.chat_id),
      Api::V1::ChatMessageSerializer.new(chat_message, current_user: chat_message.user).to_json
    )

    chat_message.set_chat_as_seen
  end
end
