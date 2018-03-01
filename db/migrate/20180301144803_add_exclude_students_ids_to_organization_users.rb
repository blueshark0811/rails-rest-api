class AddExcludeStudentsIdsToOrganizationUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :organization_users, :exclude_students_ids, :text
  end
end
