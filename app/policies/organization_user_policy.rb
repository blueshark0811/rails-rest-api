class OrganizationUserPolicy < OrganizationEntityPolicy
  class << self
    def permitted_attributes_shared
      %i[role status exclude_students_ids files_controll_enabled mesanger_access_enabled]
    end
  end

  def permitted_attributes
    self.class.permitted_attributes_shared
  end
end
