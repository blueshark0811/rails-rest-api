class ChatPolicy < OrganizationEntityPolicy
  include PolicyHelper::Attachmentable
  def permitted_attributes_for_create
    %i[title opponent_id]
  end

  def permitted_attributes_for_update
    %i[title]
  end

  def show?
    user && record.chat_user_ids.include?(user.id) || admin?
  end
end
