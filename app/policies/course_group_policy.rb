# frozen_string_literal: true

class CourseGroupPolicy < ApplicationPolicy
  def permitted_attributes
    %i[complete_lesson_can discussing_enabled files_enabled precourse_id
       reports_enabled status student_content_enabled]
  end

  def permitted_attributes_for_create
    permitted_attributes+%i[course_id]
  end
end
