class ExtendActivities < ActiveRecord::Migration[5.1]
  def change
    add_reference :activities, :task, foreign_key: true
    add_reference :activities, :lesson, foreign_key: true
    add_reference :activities, :course, foreign_key: true
    add_reference :activities, :group, foreign_key: true
    add_reference :activities, :organization, foreign_key: true
    add_reference :activities, :user, foreign_key: true
    add_column :activities, :flagged, :boolean, default: false
  end
end
