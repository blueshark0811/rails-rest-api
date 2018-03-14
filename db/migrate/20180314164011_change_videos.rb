class ChangeVideos < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :token, :string
    add_column :videos, :embed_code, :text
    rename_column :videos, :video, :sproutvideo_id
  end
end
