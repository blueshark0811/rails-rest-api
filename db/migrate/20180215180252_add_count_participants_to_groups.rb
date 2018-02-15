class AddCountParticipantsToGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :count_participants, :integer
  end
end
