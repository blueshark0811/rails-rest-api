class AddCourseGroupReferencesToCourseUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :course_users, :course_group, foreign_key: true
  end
end
