class AddLastActivityAtToGroupThreads < ActiveRecord::Migration[5.1]
  def change
    add_column :group_threads, :last_activity_at, :datetime
  end
end
