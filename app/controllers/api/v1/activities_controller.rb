class Api::V1::ActivitiesController < Api::V1::ApiController
  before_action :set_notifiable
  before_action :set_activity, except: %i[index]

  #for submission activity - user notifiable=Current-Teacher
  def index
    order = if Activity::SORT_FIELDS.include?(params[:sort_field])
      { params[:sort_field] => sort_flag }
    else
      { created_at: sort_flag }
    end

    where = {}

    where[:flagged] = bparams(:flagged) if bparams(:flagged)
    where[:status] = params[:status] if params[:status]
    where[:user_id] = params[:user_id] if params[:user_id]
    where[:lesson_id] = params[:lesson_id] if params[:lesson_id]
    where[:course_id] = params[:course_id] if params[:course_id]

    @activities = policy_scope(scope)
    # .where(where).order(order)
      # .page(current_page).per(current_count)

    render_result @activities
  end

  def destroy
    @activity.destroy

    render_result success: @activity.destroyed?
  end

  def update
    if @activity.update_attributes permitted_attributes(@activity)
      render_result(@activity) else render_error(@activity)
    end
  end

  private

  def scope
    @notifiable.activities
  end

  def set_notifiable
    unless Activity::NOTIFIABLES.include?(params[:notifiable_type])
      render_error('wrong notifiable type')
      return
    end

    @notifiable = params[:notifiable_type].constantize.find params[:notifiable_id]

    authorize @notifiable, :show_activity?
  end

  def set_activity
    @activity = scope.find params[:id]

    authorize @activity
  end
end
