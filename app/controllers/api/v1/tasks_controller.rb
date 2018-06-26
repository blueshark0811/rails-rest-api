class Api::V1::TasksController < Api::V1::ApiController
  before_action :set_group, only: %i[index show]
  before_action :set_course
  before_action :set_lesson
  before_action :set_task, except: [:index, :create]

  def index
    render_result @lesson.tasks.page(current_page).per(current_count)
  end

  def show
    @task_user = @task.add_student(current_user, @group) if student?

    render_result @task
  end

  def update
    if @task.update permitted_attributes(@task)
      render_result(@task) else render_error(@task)
    end
  end

  def destroy
    @task.destroy

    render_result success: @task.destroyed?
  end

  def create
    @task = @lesson.tasks.new user_id: current_user.id

    authorize @task

    if @task.update permitted_attributes(@task)
      render_result(@task) else render_error(@task)
    end
  end

  private

  def set_group
    p current_user, admin?, '*'*100
    if params[:group_id].blank?
      render_404('group_id should be sent') unless admin?
      return
    end

    @group = current_organization.groups.find params[:group_id]

    authorize @group, :show?
  end

  def set_course
    @course = (@group ? @group.courses : current_organization.courses).find params[:course_id]

    authorize @course, :show?
  end

  def set_lesson
    @lesson = @course.lessons.find params[:lesson_id]
  end

  def set_task
    @task = @lesson.tasks.find params[:id]

    authorize @task
  end
end
