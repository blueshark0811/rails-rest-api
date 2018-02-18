class Api::V1::GroupsController < Api::V1::ApiController
  before_action :set_group, only: %i[show update destroy]
  def index
    @groups = current_organization.groups

    if params[:participated]
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

  def show
    render_result @group
  end

  def update
    @group = current_organization.groups.find params[:id]

    if @group.update_attributes permitted_attributes(@group)
      render_result user: @group
    else
      render_result @group
    end
  end

  private

  def set_group
    p current_organization
    p Group.find params[:id]
    p current_user.organizations
    @group = current_organization.groups.find params[:id]
  end
end
