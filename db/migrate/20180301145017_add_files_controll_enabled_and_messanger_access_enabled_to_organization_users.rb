class AddFilesControllEnabledAndMessangerAccessEnabledToOrganizationUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :organization_users, :files_controll_enabled, :boolean
    add_column :organization_users, :mesanger_access_enabled, :boolean
  end
end
