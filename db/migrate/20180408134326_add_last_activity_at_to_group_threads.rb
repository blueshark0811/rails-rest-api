class AddLastActivityAtToCourseThreads < ActiveRecord::Migration[5.1]
  def change
    add_column :course_threads, :last_activity_at, :datetime
  end
end
