class Chat < ApplicationRecord
  has_many :chat_users
  has_many :users, through: :chat_users
  has_many :chat_messages
  belongs_to :organization
  has_many :attachments, as: :attachmentable, dependent: :destroy

  scope :available_for_user, ->(user_id) {
    user_id = user_id.id if user_id.is_a?(User)
    joins(:chat_users).where(chat_users: { user_id: user_id })
  }

  def channel
    self.class.channel id
  end

  class << self
    def channel(id)
      "chat_#{id}_channel"
    end

    def find_or_create(organization, user_id1, user_id2, params = {})
      return unless organization

      organization = Organization.find(organization_id) unless organization.is_a?(Organization)
      user_id1 = user_id1.id if user_id1.is_a?(User)
      user_id2 = user_id2.id if user_id2.is_a?(User)

      chat = organization.chats.where('(SELECT COUNT(id) FROM chat_users 
         WHERE (user_id = ? OR user_id = ?) AND chat_id = chats.id) = 2',
        user_id1, user_id2).first

      unless chat
        chat = organization.chats.create params
        chat.chat_users.create user_id: user_id1
        chat.chat_users.create user_id: user_id2
      end

      chat
    end
  end
end
