# frozen_string_literal: true

require 'swagger_helper'

describe Api::V1::VideosController do
  let(:organization) { create :organization }
  let(:current_user) { create :user, role: 'admin', organization: organization }

  #task ->
  let(:group) { create :group, organization: organization }
  let(:course) { create :course, organization: organization }
  let(:course_group) { create :course_group, course: course, group: group, precourse: nil }
  let(:lesson) { create :lesson, course: course }

  let!(:course_user) { create :course_user, user: current_user, course: course, course_group: course_group }
  let!(:group_user) { create :group_user, user: current_user, group: group }
  let!(:lesson_user) { create :lesson_user, lesson: lesson, user: current_user, course_group: course_group }
 
  let(:task) { create :task, lesson: lesson }
  ###

  let(:videoable) { task }
  let!(:video) { create :video_link, videoable: videoable, user: current_user, organization: organization }
  let(:rswag_properties) do {
      current_user: current_user,
      current_organization: organization,
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
    slug: "#{options[:slug]}/get_token",
    description: 'Get token for uploading video to Sproutvideo',
    additional_body: {
      video: { model: 'sproutvideo' }
    }
  )
  crud_update options.merge(description: 'Update Video')
  crud_delete options.merge(description: 'Delete Video')
end
