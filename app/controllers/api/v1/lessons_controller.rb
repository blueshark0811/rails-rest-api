# frozen_string_literal: true

class Api::V1::LessonsController < Api::V1::ApiController
  before_action :set_group, only: %i[index show complete]
  before_action :set_course
  before_action :set_lesson, except: %i[index create]

  def index
    render_result scope.page(current_page).per(current_count)
  end

  def show
    authorize(@lesson, :easy_show?) # easy.. as we checking with course already

    @lesson.add_student(current_user, @group) if student?
    Activity.mark_as_read(current_user, @lesson) if teacher?
    render_result @lesson
  end

  def complete
    if params[:student_id]
      @current_student = current_organization.students.find(params[:student_id])
    elsif student?
      @current_student = current_user
    else
      return render_error('invalid student')
    end

    @lesson_user = @lesson.add_student(@current_student, @group)

    authorize @lesson_user, :easy_complete? # easy.. as we checking with course already

    if (bparams(:completed) ? @lesson_user.completed! : @lesson_user.active!)
      render_result(success: true) else render_error(@lesson_user)
    end
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

  def scope
    policy_scope(@course.lessons)
  end

  def set_group
    if params[:group_id].blank?
      render_404 unless admin?
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
    @lesson = scope.find params[:id]

    authorize(@lesson) unless %w(complete show).include?(params[:action])
  end
end
