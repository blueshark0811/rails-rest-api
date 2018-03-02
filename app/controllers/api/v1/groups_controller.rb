class Api::V1::GroupsController < Api::V1::ApiController
  before_action :set_group, except: [:index, :create]

  def index
    where = { organization_id: current_organization.id }

    if params[:my] && params[:my] != 'false'
      where.merge!(user_ids: current_user.id)
    end

    if Group.visibilities.include?(params[:visibility])
      where.merge!(visibility: params[:visibility])
    end

    if Group.statuses.include?(params[:status])
      where.merge!(status: params[:status])
    end

    order = { title: sort_flag }

    @groups = Group.search params[:term] || '*', 
      where: where,
      order: order,
      page: current_page,
      per_page: current_count,
      fields: Group::SEARCH_FIELDS,
      match: :word_start

    render_result @groups
  end

  def show
    render_result @group
  end

  def create
    @group = current_organization.groups.new user_id: current_user.id

    if @group.update permitted_attributes(@group)
      render_result @group
    else
      render_error @group
    end
  end

  def update
    if @group.update_attributes permitted_attributes(@group)
      render_result @group
    else
      render_error @group
    end
  end

  def destroy
    @group.destroy

    render_result success: @group.destroyed?
  end

  private

  def set_group
    @group = current_organization.groups.find params[:id]

    authorize @group
  end
end
