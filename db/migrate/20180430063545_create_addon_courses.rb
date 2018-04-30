class CreateAddonCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :addon_courses do |t|
      t.references :addon, foreign_key: true
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
