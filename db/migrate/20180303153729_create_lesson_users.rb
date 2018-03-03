class CreateLessonUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :lesson_users do |t|
      t.references :lesson, foreign_key: true
      t.references :user, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
