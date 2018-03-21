class ChatsChannel < ApplicationCable::Channel
  def subscribed
    chat_user.touch
    stream_from chat.channel
  end

  def unsubscribed
  end

  def send_message(data)
    chat.chat_messages.create! message: data['message'], user_id: current_user.id
  end

  private

  def chat_user
    @chat_user ||= chat.chat_users.find_by user_id: current_user.id
  end

  def chat
    return @chat if @chat

    id = params['chat_id'] || params['data']['chat_id']

    @chat = Chat.available_for_user(current_user).find(id) if id

    opponent_id = params['opponent_id'] || params['data']['opponent_id']

    @chat ||= Chat.find_or_create(current_organization, current_user, opponent_id) if opponent_id

    @chat
  end
end
