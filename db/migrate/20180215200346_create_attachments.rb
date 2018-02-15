class CreateAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :attachments do |t|
      t.string :title
      t.text :description
      t.string :file
      t.references :user, foreign_key: true
      t.references :organization, foreign_key: true

      t.timestamps
    end
  end
end
