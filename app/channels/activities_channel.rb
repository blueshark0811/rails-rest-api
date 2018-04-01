class ActivitiesChannel < ApplicationCable::Channel
  def subscribed
    stream_from Activity.channel(notifiable)
  end

  def unsubscribed
    #something
  end

  private

  def notifiable
    return @notifiable if @notifiable

    return reject unless Activity::NOTIFIABLES.include?(params[:notifiable_type])

    @notifiable = params[:notifiable_type].constantize.find params[:notifiable_id]

    return reject unless policy(@notifiable).show_activity?

    @notifiable
  end
end
