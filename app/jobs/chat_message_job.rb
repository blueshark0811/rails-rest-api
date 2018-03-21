class ChatMessageJob < ApplicationJob
  queue_as :important

  def perform chat_message
    ActionCable.server.broadcast(
      Chat.channel(chat_message.chat_id),
      Api::ApplicationController.new.render_result(chat_message)
    )

    chat_message.set_chat_as_seen
  end
end
