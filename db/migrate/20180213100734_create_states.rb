class CreateStates < ActiveRecord::Migration[5.1]
  def change
    create_table :states do |t|
      t.string :name
      t.references :country, foreign_key: true
      t.string :code

      t.timestamps
    end
  end
end
