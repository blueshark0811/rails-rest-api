# frozen_string_literal: true

class Api::V1::LessonsController < Api::V1::ApiController
  before_action :set_course
  before_action :set_lesson, except: %i[index create]

  def index
    @lessons = @course.lessons.page(current_page).per(current_count)

    render_result @lessons
  end

  def show
    render_result @lesson
  end

  def create
    @lesson = @course.lessons.new user_id: current_user.id

    if @lesson.update permitted_attributes(@lesson)
      render_result @lesson
    else
      render_error @lesson
    end
  end

  def update
    if @lesson.update_attributes permitted_attributes(@lesson)
      render_result @lesson
    else
      render_error @lesson
    end
  end

  def destroy
    @lesson.destroy

    render_result success: @lesson.destroyed?
  end

  private

  def set_course
    @course = current_organization.courses.find params[:course_id]
  end

  def set_lesson
    @lesson = @course.lessons.find params[:id]

    authorize @lesson
  end
end
