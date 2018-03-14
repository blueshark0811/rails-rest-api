class Api::V1::VideoSerializer < BaseSerializer
  include ApiSerializer

  attribute :sproutvideo_callback_url

  belongs_to :videoable

  def sproutvideo_callback_url
    return unless object.draft?

    url_helpers.sproutvideo_api_v1_video_url(
      id: object.id,
      token: object.token,
      videoable_id: object.videoable_id,
      videoable_type: object.videoable_type
    )
  end
end
