class Api::V1::CourseGroupsController < Api::V1::ApiController
  before_action :set_group
  before_action :set_course_group, only: %i[update destroy]

  def create
    @course_group = @group.course_groups.new

    authorize @course_group

    if @course_group.update permitted_attributes(@course_group)
      render_result @course_group
    else
      render_error @course_group
    end
  end

  def update
    if @course_group.update permitted_attributes(@course_group)
      render_result @course_group
    else
      render_error @course_group
    end
  end

  def destroy
    @course_group.destroy

    render_result success: @course_group.destroyed?
  end

  private

  def set_group
    @group = current_organization.groups.find params[:group_id]
  end

  def set_course_group
    @course_group = @group.course_groups.find params[:id] if params[:id]
    @course_group ||= @group.course_groups.find_by! user_id: params[:course_id]

    authorize @course_group
  end
end
