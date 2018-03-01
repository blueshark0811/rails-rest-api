# frozen_string_literal: true

class Api::V1::UsersController < Api::V1::ApiController
  before_action :set_user, except: [:index, :create]

  def index
    @users = current_organization.users

    if params[:group_id]
      @users = @users.joins(:group_users).where(group_users: { group_id: params[:group_id] })
    end

    render_result @users.page(current_page).per(current_count)
  end

  def show
    render_result @user
  end

  def update
    if @user.update_attributes permitted_attributes(@user)
      render_result @user
    else
      render_error @user
    end
  end

  def destroy
    render_result success: @user.deleted!
  end

  def create
    @user = User.new

    if @user.update permitted_attributes(@user)
      render_result @user
    else
      render_error @user
    end
  end

  private

  def set_user
    @user = User.find params[:id]

    authorize @user
  end
end
