# frozen_string_literal: true

class Api::V1::LessonsController < Api::V1::ApiController
  before_action :set_group, only: %i[index show]
  before_action :set_course
  before_action :set_lesson, except: %i[index create]

  def index
    @lessons = policy_scope(@course.lessons).page(current_page).per(current_count)

    render_result @lessons
  end

  def show
    @lesson.add_student(current_user, @group) if current_role == 'student'
    render_result @lesson
  end

  def create
    @lesson = @course.lessons.new user_id: current_user.id

    authorize @lesson

    if @lesson.update permitted_attributes(@lesson)
      render_result(@lesson) else render_error(@lesson)
    end
  end

  def update
    if @lesson.update_attributes permitted_attributes(@lesson)
      render_result(@lesson) else render_error(@lesson)
    end
  end

  def destroy
    @lesson.destroy

    render_result success: @lesson.destroyed?
  end

  protected

  def set_group
    if params[:group_id].blank?
      render_404 if current_role != 'admin'
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
    @lesson = policy_scope(@course.lessons).find params[:id]

    authorize @lesson
  end
end
