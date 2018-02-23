class Api::V1::CoursesController < Api::V1::ApiController
  before_action :set_course, except: [:index]

  def index
    @courses = current_organization.courses

    render_result @courses.page(current_page).per(current_count)
  end

  def show
    render_result @course
  end

  def update
    if @course.update_attributes permitted_attributes(@course)
      render_result @course
    else
      render_error @course
    end
  end

  def destroy
    @course.destroy

    render_result success: @course.destroyed?
  end

  private

  def set_course
    @course = current_organization.courses.find params[:id]

    authorize @course
  end
end
