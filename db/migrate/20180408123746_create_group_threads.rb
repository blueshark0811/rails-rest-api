class CreateCourseThreads < ActiveRecord::Migration[5.1]
  def change
    create_table :course_threads do |t|
      t.string :title
      t.references :user, foreign_key: true
      t.references :group, foreign_key: true
      t.integer :comments_count, default: 0

      t.timestamps
    end
  end
end
