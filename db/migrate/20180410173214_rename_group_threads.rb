class RenameGroupThreads < ActiveRecord::Migration[5.1]
  def change
    rename_table :group_threads, :course_threads
    remove_reference :course_threads, :group
    add_reference :course_threads, :course_group
  end
end
