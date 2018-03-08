class AttachmentPolicy < OrganizationEntityPolicy
  def permitted_attributes
    %i[attachmentable_id attachmentable_type description data title]
  end
end
