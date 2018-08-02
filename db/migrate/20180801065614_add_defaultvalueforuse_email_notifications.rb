class AddDefaultvalueforuseEmailNotifications < ActiveRecord::Migration[5.1]
  def change
  	remove_column :users, :email_notifications
  	add_column :users, :email_notifications, :jsonb, default: {notify_on_private_message: true, notify_on_course_response: true, notify_on_group_discussion_response: true, get_weekly_activity_summary: true}
  end
end
