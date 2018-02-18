class Api::V1::SessionsController < Api::V1::ApiController
  skip_before_action :authenticate_user!, only: [:create]

  def create
    @user = User.where(email: params[:email]).first if params[:email].present?

    return invalid_login_attempt unless @user

    if @user.valid_password?(params[:password])
      if @user.confirmed?
        sign_in(@user)

        render_result(@user, 201, {token: jwt(@user)})
      else
        render_error({email: 'email is not confirmed'}, 400)
      end
      return
    end

    invalid_login_attempt
  end

  def destroy
    @user = current_user

    success = false

    if @user
      @user.forget_me!
      sign_out(@user)
      success = true
    end

    render_result success: success
  end

  protected

  def invalid_login_attempt
    warden.custom_failure!
    render_error "Error with your login or password", "wrong_credentials", 401
  end
end
