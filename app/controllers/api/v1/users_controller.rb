class Api::V1::UsersController < Api::V1::ApiController
  def show
  end

  def update
    @user = current_user

    if @user.update_attributes permitted_attributes(@user)
      render_result user: @user, token: jwt(@user)
    else
      render_error @user
    end
  end
end
