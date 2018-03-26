# frozen_string_literal: true

require 'swagger_helper'

describe Api::V1::VideosController do
  let!(:videoable) { current_user.organizations.first }
  let!(:video) { create :video_link, videoable: videoable, user: current_user, organization: videoable }
  let(:rswag_properties) do {
      current_user: current_user,
      current_organization: current_user.organizations.first,
      object: video
    }
  end
  let!(:videoable_id) { videoable.id }
  let!(:videoable_type) { videoable.class.name }

  options = {
    klass: Video,
    slug: '{videoable_type}/{videoable_id}/videos',
    tag: 'Videos',
    additional_parameters: [{
      name: :videoable_id,
      in: :path,
      type: :integer,
      required: true
    }, {
      name: :videoable_type,
      in: :path,
      type: :string,
      required: true
    }]
  }

  crud_index options.merge(description: 'Videos')
  crud_create options.merge(
    description: 'Add Video with youtube link',
    additional_body: {
      video: {
        model: 'link',
        video_link: 'https://youtu.be/BL50xRTnHTQ'
      }
    }
  )
  crud_create options.merge(
    slug: '{videoable_type}/{videoable_id}/videos/get_token',
    description: 'Get token for uploading video to Sproutvideo',
    additional_body: {
      video: { model: 'sproutvideo' }
    }
  )
  crud_update options.merge(description: 'Update Video')
  crud_delete options.merge(description: 'Delete Video')
end
