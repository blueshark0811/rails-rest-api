class Activity < ApplicationRecord
  EVENTABLES = %w[Comment ChatMessage]
  NOTIFIABLES = %w[User Group]

  # what trigger notification
  belongs_to :eventable, polymorphic: true
  # what should be notify
  belongs_to :notifiable, polymorphic: true

  validates :message, presence: true

  store_accessor :message, :plain, :as_object 
  #as_object should contain i18n path and variables if should be passed to localization

  enumerate :status

  def plain_message
    return plain if plain.presence

    path = as_object['i18n'].is_a?(String) ? as_object['i18n'] : as_object['i18n'].join('.')
    I18n.t("activity.messages.#{path}", (as_object['variables'] || {}).with_indifferent_access)
  end

  def channel
    self.class.channel notifiable
  end

  class << self
    def channel(notifiable)
      "#{notifiable_type.downcase}_#{notifiable_id}_channel"
    end

    def message_link object, title = nil
      object = OpenStruct.new(object) if object.is_a?(Hash)
      object_type = object.try(:object_type) || object.class.name

      title ||= object.try(:title)
      title ||= object.try(:name)
      title ||= object_type

      "<a href='#' data-object-id='#{object.id}' data-object-type='#{object_type}'>#{title}</a>"
    end
  end
end
