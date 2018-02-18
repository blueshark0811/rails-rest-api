class CreateVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
      t.string :title
      t.integer :length
      t.string :video
      t.references :organization, foreign_key: true
      t.references :user, foreign_key: true
      t.references :videoable, polymorphic: true

      t.timestamps
    end
  end
end
