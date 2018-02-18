class Api::V1::RegistrationsController < Api::V1::ApiController
  skip_before_action :authenticate_user!

  def create
    @user = User.new

    if @user.update permitted_attributes(@user)
      render_result(@user, 201, {token: jwt(@user)})
    else
      render_error @user.errors.messages, "wrong_data", 400, false
    end
  end
end