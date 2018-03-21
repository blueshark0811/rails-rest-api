class Api::V1::PasswordsController < Api::V1::ApiController
  skip_before_action :authenticate_user!
  skip_before_action :authenticate_organization!
  before_action :set_user, only: %i[create]

  def create
    if @user
      @user.send_reset_password_instructions
      render_result success: true
    else
      render_error('user is not exist', 400)
    end
  end

  def update
    if (@user = User.reset_password_by_token(permited_params)) && @user.errors.empty?
      render_result(@user, 201, @user.jwt_token, :token)
    else
      render_error 'invalid data'
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id]) if params[:id]
    @user ||= User.find_by(email: params[:email]) if params[:email]
  end

  def permited_params
    params.permit(:password, :password_confirmation, :reset_password_token)
  end
end
