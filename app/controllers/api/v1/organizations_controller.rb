class Api::V1::OrganizationsController < Api::V1::ApiController
  before_action :set_organization, except: %i[index create]

  def show
    render_result @organization
  end

  def update
    if @organization.update_attributes permitted_attributes(@organization)
      render_result(@organization) else render_error(@organization)
    end
  end

  def destroy
    @organization.destroy

    render_result success: @organization.destroyed?
  end

  private

  def set_organization
    @organization = Organization.find params[:id]

    authorize @organization
  end
end
