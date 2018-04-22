class OrganizationUserPolicy < OrganizationEntityPolicy
  class << self
    def permitted_attributes_shared
      %i[
         role status exclude_students_ids
         files_controll_enabled messanger_access_enabled
         activity_course_ids activity_student_ids
        ]
    end
  end

  def permitted_attributes
    self.class.permitted_attributes_shared + [:user_id]
  end
end
