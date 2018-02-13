class Api::V1::UsersController < Api::V1::ApiController
  def show
  end

  def update
    @user = current_user

    if @user.update_attributes permitted_params
      render_result user: @user, token: jwt(@user)
    else
      render_result user: @user, errors: @user.errors.details, error_messages: @user.errors.messages
    end
  end

  private

  def permitted_params
    params[:user].permit(:first_name, :last_name, :email)
  end
end
