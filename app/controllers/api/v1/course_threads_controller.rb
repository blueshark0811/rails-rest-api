class Api::V1::CourseThreadsController < Api::V1::ApiController
  before_action :set_group
  before_action :set_course
  before_action :set_group_thread, except: %i[index create]

  def index
    order = { id: sort_flag }

    if CourseThread::SORT_FIELDS.include?(params[:sort_field])
      order = { params[:sort_field] => sort_flag }
    end

    render_result scope.order(order).page(current_page).per(current_count)
  end

  def show
    render_result @course_thread
  end

  def update
    if @course_thread.update_attributes permitted_attributes(@course_thread)
      render_result(@course_thread) else render_error(@course_thread)
    end
  end

  def destroy
    @course_thread.destroy

    render_result success: @course_thread.destroyed?
  end

  def create
    @course_thread = scope.new(
      user: current_user, 
      course_group: @group.course_groups.find_by(course: @course)
    )

    authorize @course_thread

    if @course_thread.update permitted_attributes(@course_thread)
      render_result(@course_thread) else render_error(@course_thread)
    end
  end

  private

  def set_group
    @group = current_organization.groups.find params[:group_id]

    authorize @group, :show?
  end

  def set_course
    @course = @group.courses.find params[:course_id]

    authorize @course, :show?
  end

  def set_group_thread
    @course_thread = scope.find params[:id]

    authorize @course_thread
  end

  def scope
    policy_scope(@group.course_threads.where(course_groups: { course_id: @course.id } ))
  end
end
