class CourseUserPolicy < OrganizationEntityPolicy
  def permitted_attributes
    [:status]
  end

  def api_base_attributes
    super + [:can_start]
  end
end
