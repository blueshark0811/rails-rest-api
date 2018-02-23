class CoursePolicy < OrganizationEntityPolicy
  def permitted_attributes
    [:description, :image, :title]
  end
end
