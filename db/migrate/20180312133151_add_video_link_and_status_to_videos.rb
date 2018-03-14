class AddVideoLinkAndStatusToVideos < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :video_link, :string
    add_column :videos, :status, :string
  end
end
