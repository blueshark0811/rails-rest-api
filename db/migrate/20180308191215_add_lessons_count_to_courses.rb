class AddLessonsCountToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :lessons_count, :integer, default: 0
  end
end
