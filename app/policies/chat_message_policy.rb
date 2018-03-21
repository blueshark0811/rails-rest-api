class ChatMessagePolicy < OrganizationEntityPolicy
  def permitted_attributes
    %i[message to_user_id]
  end
end
