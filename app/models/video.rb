require 'sproutvideo'

class Video < ApplicationRecord
  VIDEOABLES = %w[Task Organization]

  belongs_to :organization
  belongs_to :user
  belongs_to :videoable, polymorphic: true, optional: true

  enumerate :status

  #validate :validate_video

  before_validation :set_data
  before_validation :set_token, on: :create

  def update_via_sproutvideo! params
    return if params['token'] != token

    update_attributes embed_code: params['embed_code'],
                      length: params['duration'],
                      status: MODELS.dig('video', 'sproutvideo', 'states', params[:state])
  end

  private

  def validate_video
    return if video_link.present? || video.present?

    errors.add(:video, :blank)
    errors.add(:video_link, :blank)
  end

  def set_token
    return if video_link.present?

    self.token = Sproutvideo::UploadToken.create(
      seconds_valid: APP_CONFIG['sproutvideo']['token_minutes_live']
    )
  rescue
    errors.add(:token, 'some problem')
  end

  def set_data
    self.status = 'ready' if video_link.present?

    return if organization_id.present? || attachmentable.blank?

    self.organization_id = attachmentable.try(:organization_id)
  end
end
