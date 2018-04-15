class AddPositionToCourseUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :course_users, :position, :integer, default: 0
  end
end
