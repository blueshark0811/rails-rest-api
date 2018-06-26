# frozen_string_literal: true

class Api::V1::CoursesController < Api::V1::ApiController
  before_action :set_group, only: %i[index show switch]
  before_action :set_course, except: %i[index create]

  def index
    @courses = if student? || teacher? && params[:student_id]
      @current_student = if params[:student_id] 
        current_organization.students.find(params[:student_id])
      else
        current_user
      end
      
      Course.for_student(@current_student).page(current_page).per(current_count)
    else
      order = if Course::SORT_FIELDS.include?(params[:sort_field])
        { params[:sort_field] => sort_flag }
      else
        { title: sort_flag }
      end

      where = { organization_id: current_organization.id }

      where[:group_ids] = @group.id if @group

      Course.search params[:term] || '*',
        where: where.merge(policy_condition(Course)),
        order: order,
        load: false,
        page: current_page,
        per_page: current_count,
        match: :word_start
    end

    render_result @courses
  end

  def switch
    @current_student = current_organization.students.find(params[:student_id])
    @course_user = @course.add_student(@current_student, current_course_group)

    authorize @course_user, :easy_switch? # easy.. as we checking with group already

    if (bparams(:active) ? @course_user.active! : @course_user.disabled!)
      render_result(success: true) else render_error(@course_user)
    end
  end

  def show
    render_result @course
  end

  def create
    @course = Course.new user_id: current_user.id, organization_id: current_organization.id

    authorize @course

    if @course.update permitted_attributes(@course)
      render_result(@course) else render_error(@course)
    end
  end

  def update
    if @course.update permitted_attributes(@course)
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
      render_404('group_id should be sent') unless admin?
      return
    end

    @group = current_organization.groups.find params[:group_id]

    authorize @group, :show?
  end

  def set_course
    @course = (@group ? @group.courses : current_organization.courses).find params[:id]

    authorize(@course) unless %w[switch].include?(params[:action])
  end
end
