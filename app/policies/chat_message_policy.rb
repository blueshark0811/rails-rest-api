class ChatMessagePolicy < OrganizationEntityPolicy
  include PolicyHelper::Attachmentable

  def permitted_attributes_for_create
    %i[message to_user_id attachment_id]
  end

  def permitted_attributes_for_update
    %i[message]
  end

  def update?
    author? || super
  end

  def create?
    chat_policy.show?
  end

  def chat_policy
    @chat_policy ||= ChatPolicy.new(user_context, record.chat)
  end
end
