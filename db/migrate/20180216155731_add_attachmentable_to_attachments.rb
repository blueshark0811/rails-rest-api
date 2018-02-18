class AddAttachmentableToAttachments < ActiveRecord::Migration[5.1]
  def change
    add_reference :attachments, :attachmentable, polymorphic: true
  end
end
