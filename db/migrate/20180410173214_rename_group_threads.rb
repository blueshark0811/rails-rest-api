class RenameCourseThreads < ActiveRecord::Migration[5.1]
  def change
    rename_table :course_threads, :course_threads
    remove_reference :course_threads, :group
    add_reference :course_threads, :course_group
  end
end
