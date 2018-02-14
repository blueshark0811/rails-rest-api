class CreateOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :organizations do |t|
      t.string :title
      t.string :subdomain
      t.string :domain

      t.timestamps
    end
  end
end
