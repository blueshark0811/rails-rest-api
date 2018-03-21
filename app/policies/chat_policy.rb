class ChatPolicy < OrganizationEntityPolicy
  def permitted_attributes_for_create
    %i[title opponent_id]
  end

  def permitted_attributes_for_update
    %i[title]
  end
end
