class Api::V1::ChatSerializer < BaseSerializer
  include ApiSerializer

  has_many :users
  # has_many :chat_messages
end
