class FixTypoInOrganizationUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :organization_users, :mesanger_access_enabled, :messanger_access_enabled
  end
end
