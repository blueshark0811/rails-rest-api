class OrganizationAddonEntityPolicy < OrganizationEntityPolicy
  class Scope < Scope
    def condition
      return none unless role

      { organization_ids: organization.id }
    end
  end

  protected

  def record_accessible_in_organization?
    record.organization_ids.include?(organization.id) && role
  end
end
