# frozen_string_literal: true

class Api::V1::CoursesController < Api::V1::ApiController
  before_action :set_course, except: %i[index create]

  def index
    order = if Course::SORT_FIELDS.include?(params[:sort_field])
              { params[:sort_field] => sort_flag }
            else
              { first_name: sort_flag }
            end

    where = { organization_id: current_organization.id }

    where.merge!(group_id: params[:group_id]) if params[:group_id]

    @courses = Course.search '*',
      where: where,
      order: order, load: false, page: current_page, per_page: current_count

    render_result @courses
  end

  def show
    render_result @course
  end

  def create
    @course = current_organization.courses.new user_id: current_user.id

    if @course.update permitted_attributes(@course)
      render_result @course
    else
      render_error @course
    end
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
