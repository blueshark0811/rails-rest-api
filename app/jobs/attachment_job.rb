class AttachmentJob < ApplicationJob
  queue_as :default

  def perform(attachment_or_attachmentable, action)
    if action == 'created'
      attachment_or_attachmentable.attachmentable_callback

    elsif action == 'destroyed' && attachment_or_attachmentable.respond_to?(:attachments_count)
      attachment_or_attachmentable.update_attribute(
        :attachments_count,
        attachment_or_attachmentable.attachments_count.to_i - 1
      )
    end
  end
end
