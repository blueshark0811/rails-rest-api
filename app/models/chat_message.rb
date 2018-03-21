class ChatMessage < ApplicationRecord
  belongs_to :user
  belongs_to :chat
  has_one :organization, through: :chat

  validates :message, presence: true

  before_validation :find_chat
  after_create_commit { ChatMessageJob.perform_later(self) }

  attr_accessor :to_user_id, :organization_id

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
    chat_user_scope.update_all updated_at: Time.now
  end

  def find_chat
    return if !to_user_id || chat_id

    self.chat = Chat.find_or_create organization_id, to_user_id, user_id
  end
end
