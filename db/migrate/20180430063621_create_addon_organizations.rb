class CreateAddonOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :addon_organizations do |t|
      t.references :addon, foreign_key: true
      t.references :organization, foreign_key: true

      t.timestamps
    end

    # remove_reference :courses, :organization
  end
end
