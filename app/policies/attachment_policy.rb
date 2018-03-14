class AttachmentPolicy < OrganizationEntityPolicy
  class << self
    def permitted_attributes_shared
      %i[description data title]
    end
  end

  def permitted_attributes
    %i[attachmentable_id attachmentable_type] + self.class.permitted_attributes_shared
  end
end
