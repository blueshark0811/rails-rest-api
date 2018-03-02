# frozen_string_literal: true

class CoursePolicy < OrganizationEntityPolicy
  def permitted_attributes
    %i[description image title]
  end
end
