class Api::V1::GroupUsersController < Api::V1::ApiController
  before_action :set_group
  before_action :set_group_user, only: %i[update destroy]

  def index
    order = if GroupUser::SORT_FIELDS.include?(params[:sort_field])
              { params[:sort_field] => sort_flag }
            else
              { first_name: sort_flag }
            end

    where = {}
    where[:group_id] = @group.id if @group

    @group_users = GroupUser.search '*',
      where: where.merge(policy_condition(GroupUser)),
      order: order, load: false, page: current_page, per_page: current_count

    render_result @group_users
  end

  def create
    @group_user = @group.group_users.new user_id: params[:group_user][:user_id]

    authorize @group_user

    if @group_user.update permitted_attributes(@group_user)
      render_result(@group_user) else render_error(@group_user)
    end
  end

  def update
    if @group_user.update permitted_attributes(@group_user)
      render_result(@group_user) else render_error(@group_user)
    end
  end

  # params:
  # ids - array of id group_users
  # status - new status of group_user
  def batch_update
    errors = []

    @group.group_users.where(id: params[:ids]).each do |group_user|
      authorize group_user, :update?

      unless group_user.update status: params[:status]
        errors << { group_user.id => group_user.errors.details }
      end
    end

    render_result errors: errors, success: errors.blank?
  end

  def destroy
    @group_user.destroy

    render_result success: @group_user.destroyed?
  end

  private

  def set_group
    @group = current_organization.groups.find params[:group_id]

    authorize @group, :show?
  end

  def set_group_user
    @group_user = @group.group_users.find params[:id] if params[:id]
    @group_user ||= @group.group_users.find_by! user_id: params[:user_id]

    authorize @group_user
  end
end
