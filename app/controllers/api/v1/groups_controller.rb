class Api::V1::GroupsController < Api::V1::ApiController
  before_action :set_group, except: [:index]

  def index
    @groups = current_organization.groups

    if params[:my] && params[:my] != 'false'
      @groups = @groups.participated_by(current_user)
    end

    if Group.visibilities.include?(params[:visibility])
      @groups = @groups.where(visibility: params[:visibility])
    end

    if Group.statuses.include?(params[:status])
      @groups = @groups.where(status: params[:status])
    end

    render_result @groups.page(current_page).per(current_count)
  end

  def search
    @groups = Group.search(
      params[:term],
      match: :word_start,
      where: { organization_id: current_organization.id }
    )

    render_result @groups.page(current_page).per(current_count)
  end

  def show
    render_result @group
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
