class RenameActionsToTasks < ActiveRecord::Migration[5.1]
  def change
    rename_table :actions, :tasks
  end
end
