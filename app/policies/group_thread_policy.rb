class GroupThreadPolicy < OrganizationEntityPolicy
  def permitted_attributes
    %i[title]
  end

  def api_base_attributes
    super + [:last_comment]
  end

  def update?
    super || author?
  end

  def create?
    super || user.in_group?(record.group)
  end
end
