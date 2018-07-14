class AttachmentPolicy < OrganizationEntityPolicy
  class << self
    def permitted_attributes_shared
      %i[description data title data_key]
    end
  end

  def create?
    record_accessible_in_organization? &&
      (admin? || %w[Chat ChatMessage Task].include?(record.attachmentable_type))
  end

  def update?
    super_admin? || create?
  end

  def show?
    author? || update?
  end

  def permitted_attributes
    %i[attachmentable_id attachmentable_type] + self.class.permitted_attributes_shared
  end
end
