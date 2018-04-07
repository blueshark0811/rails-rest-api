class AddCourseGroupReferencesToLessonUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :lesson_users, :course_group, foreign_key: true
  end
end
