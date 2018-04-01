class Api::V1::ActivitiesController < Api::V1::ApiController
  before_action :set_notifiable
  before_action :set_activity, except: %i[index]

  def index
    order = { created_at: sort_flag }

    @activities = policy_scope(@notifiable.activities).order(order)
      .page(current_page).per(current_count)

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

  def set_notifiable
    unless Activity::NOTIFIABLES.include?(params[:notifiable_type])
      render_error('wrong notifiable type')
      return
    end

    @notifiable = params[:notifiable_type].constantize.find params[:notifiable_id]

    authorize @notifiable, :show_activity?
  end

  def set_activity
    @activity = @notifiable.activities.find params[:id]

    authorize @activity
  end
end
