class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.references :organization, foreign_key: true
      t.string :title
      t.text :description
      t.string :status
      t.integer :user_limit
      t.string :visibility

      t.timestamps
    end
  end
end
