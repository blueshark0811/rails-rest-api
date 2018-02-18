class CreateLessons < ActiveRecord::Migration[5.1]
  def change
    create_table :lessons do |t|
      t.string :title
      t.text :description
      t.string :status
      t.references :user, foreign_key: true
      t.references :course

      t.timestamps
    end
  end
end
