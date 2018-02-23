class Api::V1::RegistrationsController < Api::V1::ApiController
  skip_before_action :authenticate_user!
  skip_before_action :authenticate_organization!

  def create
    @user = User.new

    if @user.update permitted_attributes(@user)
      render_result(@user, 201, @user.jwt_token||'', :token)
    else
      render_error @user.errors.messages, 'wrong_data', 400, false
    end
  end
end
