class AddStatusToGroupUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :group_users, :status, :string
  end
end
