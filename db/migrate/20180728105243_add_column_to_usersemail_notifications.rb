class AddColumnToUsersemailNotifications < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :enable_email_notifications, :boolean, default: true
  	add_column :users, :email_notifications, :jsonb, default: {}, null: false
  end
end
