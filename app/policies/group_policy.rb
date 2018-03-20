# frozen_string_literal: true

class GroupPolicy < OrganizationEntityPolicy
  def permitted_attributes
    %i[description status title user_limit visibility]
  end

  def comments_index?
    update? || user.group_users.where(group_id: record.id).exists?
  end
end
