class GroupPolicy < OrganizationEntityPolicy
  def permitted_attributes
    [:description, :status, :title, :user_limit, :visibility]
  end
end
