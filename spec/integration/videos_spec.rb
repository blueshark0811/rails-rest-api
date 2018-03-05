# frozen_string_literal: true

require 'swagger_helper'

describe Api::V1::VideosController do
  let!(:videoable) { current_user.organizations.first }
  let!(:video) { create :video, videoable: videoable, user: current_user, organization: videoable }
  let(:rswag_properties) { { current_user: current_user, object: video } }
  let!(:videoable_id) { videoable.id }
  let(:videoable_type) { videoable.class.name }

  options = { 
    klass: Video,
    slug: '{videoable_type}/{videoable_id}/videos',
    tag: 'Videos'
  }

  additional_params = [{
    name: :videoable_id,
    in: :path,
    type: :integer,
    required: true
  },{
    name: :videoable_type,
    in: :path,
    type: :string,
    required: true
  }]

  crud_index options.merge(description: 'Videos') do
    let(:additional_parameters) { additional_params }
  end

  crud_create options.merge(description: 'Add Video') do
    let(:additional_parameters) { additional_params }
  end

  crud_update options.merge(description: 'Update Video') do
    let(:additional_parameters) { additional_params }
  end

  crud_delete options.merge(description: 'Delete Video') do
    let(:additional_parameters) { additional_params }
  end
end
