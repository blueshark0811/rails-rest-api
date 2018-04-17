# frozen_string_literal: true

class LessonUserPolicy < ApplicationPolicy
  def permitted_attributes
    %i[lesson_id status user_id]
  end

  def api_base_attributes
    %i[status created_at course_settings]
  end

  def complete?
    lesson_policy.show? && easy_complete?
  end

  def easy_complete?
    (author? && course_group.complete_lesson_can_student?) ||
      (teacher? && course_group.complete_lesson_can_teacher?)
  end

  def course_group
    @course_group ||= record.course_group
  end

  def lesson_policy
    @lesson_policy ||= LessonPolicy.new(user_context, record.lesson)
  end
end
