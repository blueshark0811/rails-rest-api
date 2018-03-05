class OrganizationUserPolicy < OrganizationEntityPolicy
  def permitted_attributes
    %i[exclude_students_ids files_controll_enabled mesanger_access_enabled role status]
  end
end
