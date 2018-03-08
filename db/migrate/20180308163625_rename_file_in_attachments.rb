class RenameFileInAttachments < ActiveRecord::Migration[5.1]
  def change
    rename_column :attachments, :file, :data
  end
end
