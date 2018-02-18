class Api::V1::UsersController < Api::V1::ApiController
  def index
    @users = current_organization.users

    render_result @users.page(current_page).per(current_count)
  end

  def show
    @user = User.find(params[:id]) if params[:id].to_i > 0

    @user ||= current_user

    render_result @user
  end

  def update
    @user = current_user # User.find(params[:id])

    if @user.update_attributes permitted_attributes @user
      render_result @user
    else
      render_error @user
    end
  end
end
