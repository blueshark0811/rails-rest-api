class AddTreePathToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :tree_path, :text, array: true, default: []
  end
end
