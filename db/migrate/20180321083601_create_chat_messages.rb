class CreateChatMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :chat_messages do |t|
      t.references :user, foreign_key: true
      t.references :chat, foreign_key: true
      t.text :message

      t.timestamps
    end
  end
end
