class CreateCourseGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :course_groups do |t|
      t.references :course, foreign_key: true
      t.references :group, foreign_key: true
      t.references :precourse, references: :course, foreign_key: { to_table: :courses }
      t.string :complete_lesson_can
      t.boolean :reports_enabled
      t.boolean :files_enabled
      t.boolean :discussing_enabled
      t.boolean :student_content_enabled
      t.string :status

      t.timestamps
    end
  end
end
