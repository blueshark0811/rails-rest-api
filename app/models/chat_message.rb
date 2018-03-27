class ChatMessage < ApplicationRecord
  belongs_to :user
  belongs_to :chat
  has_one :organization, through: :chat
  has_many :attachments, as: :attachmentable, dependent: :destroy

  validates :message, presence: true

  before_validation :find_chat
  after_create_commit { ChatMessageJob.perform_later(self) }
  after_create :move_attachment

  attr_accessor :to_user_id, :organization_id, :attachment_id

  class << self
    def additional_attributes#todo move description to config
      { 
        to_user_id: {
          type: :integer,
          null: false,
          description: 'recepient of message, if chat is not determinated yet'
        },
        attachment_id: {
          type: :integer,
          null: false,
          description: 'attachment from chat, that uploaded before and should to be attached to current message'
        }
      }
    end
  end

  def organization_id
    @organization_id ||= chat&.organization_id
  end

  def chat_user_scope
    chat.chat_users.where(user_id: user_id)
  end

  def chat_user
    chat_user_scope.last
  end

  def set_chat_as_seen
    chat_user_scope.update_all(updated_at: Time.zone.now)
  end

  def find_chat
    return if !to_user_id || chat_id

    self.chat = Chat.find_or_create organization_id, to_user_id, user_id
  end

  def move_attachment
    return unless attachment_id

    return unless (attachment = chat.attachments.find_by id: attachment_id, user_id: user_id)

    attachment.update_attributes attachmentable: self
  end
end
