class ChatMessage < ApplicationRecord
  belongs_to :user
  belongs_to :chat
  has_one :organization, through: :chat
  has_many :attachments, as: :attachmentable, dependent: :destroy
  has_many :activities, as: :eventable

  validates :message, presence: true

  before_validation :find_chat
  after_create_commit { ChatMessageJob.perform_later(self) }
  after_save :move_attachment

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
    ChatUser.where(chat_id: chat_id, user_id: user_id)
  end

  def opponents
    User.where(id: ChatUser.select(:user_id).where(chat_id: chat_id).where.not(user_id: user_id))
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

  def write_activity
    opponents.each do |opponent|
      activities.create(
        notifiable: opponent, 
        as_object: {
          i18n: 'chat_message.created',
          variables: { 
            user: Activity.message_link(user),
            chat: Activity.message_link({id: chat_id, object_type: 'Chat'})
          }
        }
      )
    end
  end
end
