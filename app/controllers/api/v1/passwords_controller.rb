class Api::V1::PasswordsController < Api::V1::ApiController
  skip_before_action :authenticate_user!

  def create
    if @user
      @user.send_reset_password_code!(app_id)
      render json: { user_id: @user.id, :success => true }, status: 200
    else
      warden.custom_failure!
      render_error "Invalid login or email"
    end
  end

  def update
      valid_code = @user.valid_reset_password_code?(params[:code])

      if valid_code && @user && @user.update_attributes(permited_params)
        render_result(:token => jwt(@user), @scope => @user)
      else
        valid_code ?
            render_error("Invalid user params", "invalid_user_params") :
            render_error("Invalid code", "invalid_sms_code")
      end
    else
      warden.custom_failure!
      render_error "Invalid login or email"
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id]) if params[:id]
    @user ||= User.find_by(email: params[:email]) if params[:email]
  end

  def permited_params
    params[:user].permit(:password, :password_confirmation)
  end
end
