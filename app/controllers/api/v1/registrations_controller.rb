class Api::V1::RegistrationsController < Api::V1::ApiController
  skip_before_action :authenticate_user!
  skip_before_action :authenticate_organization!

  def create
    @user = User.new

    if @user.update permitted_attributes(@user)
      render_result(@user, 201, @user.jwt_token||'', :token)
    else
      render_error @user
    end
  end

  def send_instruction
    @user = User.find_by(id: params[:user_id]) if params[:user_id].present?
    @user = User.find_by email: params[:email] if params[:email].present? && !@user

    render_error('invalid user') && return unless @user

    @user.send_confirmation_instructions

    render_result success: true
  end

  def confirm
    @user = User.confirm_by_token params[:token]

    if @user.errors.blank?
      render_result(@user, 201, @user.jwt_token||'', :token) else render_error(@user.errors.full_messages)
    end
  end
end
