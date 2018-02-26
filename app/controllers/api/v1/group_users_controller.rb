class Api::V1::GroupUsersController < Api::V1::ApiController
  before_action :set_group
  before_action :set_group_user, only: %i[update destroy]

  def index
    order = if GroupUser::SORT_FIELDS.include?(params[:sort_field])
      { params[:sort_field] => sort_flag }
    else
      { first_name: sort_flag }
    end

    @group_users = GroupUser.search '*', order: order, load: false, page: current_page, per_page: current_count

    render_result @group_users
  end

  def create
    @group_user = @group.group_users.create user_id: params[:user_id]

    authorize @group_user

    if @group_user.save
      render_result @group_user
    else
      render_error @group_user
    end
  end

  def update
    if @group_user.update permitted_attributes(@group_user)
      render_result @group_user
    else
      render_error @group_user
    end
  end

  def destroy
    @group_user.destroy

    render_result success: @group_user.destroyed?
  end

  private

  def set_group
    @group = current_organization.groups.find params[:group_id]
  end

  def set_user
    @user = User.find params[:user_id]
  end

  def set_group_user
    @group_user = @group.group_users.where user_id: params[:user_id]

    authorize @group_user
  end
end
