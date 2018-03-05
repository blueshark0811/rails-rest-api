class AttachmentPolicy < OrganizationEntityPolicy
  def permitted_attributes
    %i[attachmentable_id attachmentable_type description file title]
  end
end
