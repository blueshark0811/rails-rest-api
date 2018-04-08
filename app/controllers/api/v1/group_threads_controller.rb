class Api::V1::GroupThreadsController < Api::V1::ApiController
  before_action :set_group
  before_action :set_group_thread, except: %i[index create]

  def index
    order = { id: sort_flag }

    if GroupThread::SORT_FIELDS.include?(params[:sort_field])
      order = { params[:sort_field] => sort_flag }
    end

    render_result scope.order(order).page(current_page).per(current_count)
  end

  def show
    render_result @group_thread
  end

  def update
    if @group_thread.update_attributes permitted_attributes(@group_thread)
      render_result(@group_thread) else render_error(@group_thread)
    end
  end

  def destroy
    @group_thread.destroy

    render_result success: @group_thread.destroyed?
  end

  def create
    @group_thread = scope.new user: current_user

    authorize @group_thread

    if @group_thread.update permitted_attributes(@group_thread)
      render_result(@group_thread) else render_error(@group_thread)
    end
  end

  private

  def set_group
    @group = current_organization.groups.find params[:group_id]

    authorize @group, :show?
  end

  def set_group_thread
    @group_thread = scope.find params[:id]

    authorize @group_thread
  end

  def scope
    policy_scope(@group.group_threads)
  end
end
