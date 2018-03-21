class Api::V1::ChatMessagesController < Api::V1::ApiController
  before_action :set_chat
  before_action :set_chat_message, except: %i[index create]

  def index
    order = { id: sort_flag }

    where = {}

    @chat_messages = policy_scope(ChatMessage).where(where).order(order)
      .page(current_page).per(current_count)

    render_result @chat_messages
  end

  def create
    @chats_message = @chat.chat_messages.new user_id: current_user.id

    authorize @chats_message

    if @chats_message.update permitted_attributes(@chats_message)
      render_result(@chats_message) else render_error(@chats_message)
    end
  end

  def update
    if @chat_message.update_attributes permitted_attributes(@chat_message)
      render_result(@chat_message) else render_error(@chat_message)
    end
  end

  def destroy
    @chat_message.destroy

    render_result success: @chat_message.destroyed?
  end

  private

  def set_chat
    @chat = Chat.find params[:chat_id]

    authorize @chat, :show?
  end

  def set_chat_message
    @chat_message = @chat.chat_messages.find params[:id]

    authorize @chat_message
  end
end
