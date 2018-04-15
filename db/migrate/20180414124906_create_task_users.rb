class CreateTaskUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :task_users do |t|
      t.references :task, foreign_key: true
      t.references :user, foreign_key: true
      t.references :course_group, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
