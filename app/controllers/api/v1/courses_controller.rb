# frozen_string_literal: true

class Api::V1::CoursesController < Api::V1::ApiController
  before_action :set_group, only: %i[index show]
  before_action :set_course, except: %i[index create]

  def index
    order = if Course::SORT_FIELDS.include?(params[:sort_field])
              { params[:sort_field] => sort_flag }
            else
              { title: sort_flag }
            end

    where = { organization_id: current_organization.id }

    where[:group_ids] = @group.id if @group

    @courses = Course.search params[:term] || '*',
      where: where.merge(policy_condition(Course)),
      order: order,
      load: false,
      page: current_page,
      per_page: current_count,
      match: :word_start

    render_result @courses
  end

  def show
    render_result @course
  end

  def create
    @course = current_organization.courses.new user_id: current_user.id

    authorize @course

    if @course.update permitted_attributes(@course)
      render_result(@course) else render_error(@course)
    end
  end

  def update
    if @course.update_attributes permitted_attributes(@course)
      render_result(@course) else render_error(@course)
    end
  end

  def destroy
    @course.destroy

    render_result success: @course.destroyed?
  end

  private

  def set_group
    if params[:group_id].blank?
      render_404 if current_role != 'admin'
      return
    end

    @group = current_organization.groups.find params[:group_id]

    authorize @group, :show?
  end

  def set_course
    @course = (@group ? @group.courses : current_organization.courses).find params[:id]

    authorize @course
  end
end
