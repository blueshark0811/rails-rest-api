class Api::V1::ChatsController < Api::V1::ApiController
  before_action :set_chat, except: %i[index create with_opponent]

  def index
    order = { id: sort_flag }

    where = policy_condition(Chat)

    @chats = policy_scope(Chat).where(where).order(order)
      .page(current_page).per(current_count)

    render_result @chats
  end

  def show
    render_result @chat
  end

  def with_opponent
    @opponent = User.find params[:opponent_id]

    authorize @opponent, :be_opponent?

    @chat = Chat.find_or_create current_organization, current_user, @opponent

    authorize @chat, :show?

    render_result @chat
  end

  def update
    if @chat.update_attributes permitted_attributes(@chat)
      render_result(@chat) else render_error(@chat)
    end
  end

  def destroy
    @chat.destroy

    render_result success: @chat.destroyed?
  end

  private

  def set_chat
    @chat = Chat.find params[:id]

    authorize @chat
  end
end
