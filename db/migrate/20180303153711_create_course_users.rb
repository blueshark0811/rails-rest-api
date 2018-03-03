class CreateCourseUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :course_users do |t|
      t.references :course, foreign_key: true
      t.references :user, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
