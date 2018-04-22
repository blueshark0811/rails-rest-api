class Api::V1::OrganizationUsersController < Api::V1::ApiController
  before_action :set_organization_user, except: %i[index create]

  def destroy
    @organization_user.destroy

    render_result success: @organization_user.destroyed?
  end

  def create
    @organization_user = scope.new

    authorize @organization_user

    if @organization_user.update permitted_attributes(@organization_user)
      render_result(@organization_user) else render_error(@organization_user)
    end
  end

  private

  def scope
    current_organization.organization_users
  end

  def set_organization_user
    @organization_user = scope.find params[:id]

    authorize @organization_user
  end
end
