class AddNoticeboardSettingsToGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :noticeboard_settings, :jsonb, default: {}, null: false
  end
end
