class Api::V1::ActionsController < Api::V1::ApiController
  before_action :set_lesson
  before_action :set_action, except: [:index, :create]

  def index
    order = { id: sort_flag }

    @actions = @lesson.actions.page(current_page).per(current_count)

    authorize @actions

    render_result @actions
  end

  def show
    render_result @action
  end

  def update
    if @action.update_attributes permitted_attributes(@action)
      render_result(@action) else render_error(@action)
    end
  end

  def destroy
    @action.destroy

    render_result success: @action.destroyed?
  end

  def create
    @action = @lesson.actions.new user_id: current_user.id

    authorize @action

    if @action.update permitted_attributes(@action)
      render_result(@action) else render_error(@action)
    end
  end

  private

  def set_lesson
    @lesson = Lesson.where(course_id: params[:course_id]).find params[:lesson_id]
  end

  def set_action
    @action = @lesson.actions.find params[:id]

    authorize @action
  end
end
