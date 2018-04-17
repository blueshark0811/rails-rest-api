class ActivityJob < ApplicationJob
  queue_as :default

  def perform(activity)
    return if activity.excluded_from_broadcast?

    ActionCable.server.broadcast(
      activity.channel,
      Api::V1::ActivitySerializer.new(
        activity,
        current_user: activity.notifiable_type == 'User' ? activity.notifiable : nil
      ).to_json
    )
  end
end
