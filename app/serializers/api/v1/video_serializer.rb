class Api::V1::VideoSerializer < BaseSerializer
  include ApiSerializer

  attribute :sproutvideo_callback_url

  belongs_to :videoable

  def sproutvideo_callback_url
    return ActiveModel::FieldUpgrade::ATTR_NOT_ACCEPTABLE if object.draft? || object.link?

    url_helpers.sproutvideo_api_v1_video_url(
      id: object.id,
      token: object.token,
      videoable_id: object.videoable_id,
      videoable_type: object.videoable_type
    )
  end

  %w[token embed_code sproutvideo_id].each do |field|
    define_method field do
      return ActiveModel::FieldUpgrade::ATTR_NOT_ACCEPTABLE if object.link?

      object.send field
    end
  end
end
