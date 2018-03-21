class ChatUser < ApplicationRecord
  belongs_to :user
  belongs_to :chat
  has_one :organization, through: :chat

  validates :user_id, uniqueness: { scope: [:chat_id] }

  def organization_id
    @organization_id ||= chat&.organization_id
  end
end
