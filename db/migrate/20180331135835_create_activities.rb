class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'hstore'
    create_table :activities do |t|
      t.references :eventable, polymorphic: true
      t.references :notifiable, polymorphic: true
      t.jsonb :message, default: {}, null: false
      t.string :status

      t.timestamps
    end
  end
end
