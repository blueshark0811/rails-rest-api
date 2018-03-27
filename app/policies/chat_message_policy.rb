class ChatMessagePolicy < OrganizationEntityPolicy
  def permitted_attributes_for_create
    %i[message to_user_id attachment_id]
  end

  def permitted_attributes_for_update
    %i[message]
  end
end
