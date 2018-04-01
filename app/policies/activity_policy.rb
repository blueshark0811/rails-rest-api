class ActivityPolicy < ApplicationPolicy
  def permitted_attributes
    %i[status]
  end

  def update?
    super_admin? ||
    record.notifiable_type == 'User' && record.notifiable_id == user.id ||
    record.notifiable_type == 'Group' && admin?
  end

  def destroy?
    update?
  end
end
