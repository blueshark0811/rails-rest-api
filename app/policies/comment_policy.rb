class CommentPolicy < OrganizationEntityPolicy
  def permitted_attributes
    %i[body subject title root_id attachment_id]
  end

  def update?
    super || author?
  end
end
