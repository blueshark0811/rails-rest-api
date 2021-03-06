require 'sproutvideo'

class Video < ApplicationRecord
  VIDEOABLES = %w[Task Lesson Organization]

  belongs_to :organization, optional: true
  belongs_to :user
  belongs_to :videoable, polymorphic: true, optional: true

  enumerate :status

  before_validation :set_data
  before_validation :set_token, on: :create
  before_validation :update_via_youtube, on: :create

  scope :without_draft, -> { where.not(status: 'draft') }

  attr_accessor :mode

  def mode
    @mode || 'link'
  end

  def link?
    mode == 'link'
  end

  def sproutvideo?
    mode == 'sproutvideo' || !!token
  end

  def update_via_sproutvideo!(params)
    return if params['token'] != token

    update embed_code: params['embed_code'],
           length: params['duration'],
           status: MODELS.dig('video', 'sproutvideo', 'states', params[:state])
  end

  def update_via_youtube
    return unless link?

    return errors.add(:video_link, :blank) if video_link.blank?

    video = Yt::Video.new id: youtube_id
    self.length = video.duration
    self.embed_code = video.embed_html
  rescue Yt::Errors::NoItems
    errors.add :video_link, :invalid
  end

  def youtube_id
    video_link.match(REGEXP[:youtube_id])[1] rescue video_link
  end

  private

  def set_token
    return unless sproutvideo?

    self.token = Sproutvideo::UploadToken.create(
      seconds_valid: APP_CONFIG['sproutvideo']['token_minutes_live']
    ).body[:token]
  rescue
    errors.add(:token, 'some problem')
  end

  def set_data
    self.status = 'ready' if video_link.present?

    return if organization_id.present? || videoable.blank?

    self.organization_id = videoable.try(:organization_id)
  end
end
