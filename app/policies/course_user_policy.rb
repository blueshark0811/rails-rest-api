class CourseUserPolicy < OrganizationEntityPolicy
  def permitted_attributes
    %i[status position]
  end

  def api_base_attributes
    super + [:can_start]
  end

  def easy_switch?
    admin? || teacher?
  end
end
