# frozen_string_literal: true

class Api::V1::UsersController < Api::V1::ApiController
  before_action :set_user, except: %i[index create]

  def index
    order = { first_name: sort_flag }

    where = policy_condition(User)

    where[:group_ids] = params[:group_id] if params[:group_id]

    where[:cached_roles] = [current_organization.id, params[:role]].join('_') if params[:role]

    @users = User.search params[:term] || '*',
      where: where,
      order: order,
      page: current_page,
      per_page: current_count,
      fields: User::SEARCH_FIELDS,
      match: :word_start

    authorize @users

    render_result @users
  end

  def show
    render_result @user
  end

  def update
    if @user.update permitted_attributes(@user)
      render_result(@user) else render_error(@user)
    end
  end

  def destroy
    render_result success: @user.deleted!
  end

  def create
    @user = User.new
    @user.skip_confirmation!

    authorize @user

    if @user.update permitted_attributes(@user)
      render_result(@user) else render_error(@user)
    end
  end

  def send_set_password_link
    render_result success: !!@user.send_reset_password_instructions
  end

  private

  def set_user
    @user = User.find params[:id]

    authorize @user
  end
end
