class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :role
      t.string :admin_role
      t.string :phone_number
      t.date :date_of_birth
      t.string :address
      t.references :country
      t.references :state
      t.string :zip_code
      t.string :status

      t.timestamps
    end
  end
end
