class Api::V1::TasksController < Api::V1::ApiController
  before_action :set_lesson
  before_action :set_task, except: [:index, :create]

  def index
    order = { id: sort_flag }

    @tasks = @lesson.tasks

    authorize @tasks

    render_result @tasks.page(current_page).per(current_count)
  end

  def show
    render_result @task
  end

  def update
    if @task.update_attributes permitted_attributes(@task)
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

  def set_lesson
    p Lesson.all
    @lesson = Lesson.where(course_id: params[:course_id]).find params[:lesson_id]
  end

  def set_task
    @task = @lesson.tasks.find params[:id]

    authorize @task
  end
end
