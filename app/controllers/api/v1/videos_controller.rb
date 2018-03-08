# frozen_string_literal: true

class Api::V1::VideosController < Api::V1::ApiController
  before_action :set_videoable
  before_action :set_video, except: %i[index create]

  def index
    @videos = @videoable.videos.page(current_page).per(current_count)

    render_result @videos
  end

  def show
    render_result @video
  end

  def create
    @video = @videoable.videos.new(
      user_id: current_user.id,
      organization_id: current_organization.id
    )

    if @video.update permitted_attributes(@video)
      render_result @video
    else
      render_error @video
    end
  end

  def update
    if @video.update_attributes permitted_attributes(@video)
      render_result @video
    else
      render_error @video
    end
  end

  def destroy
    @video.destroy

    render_result success: @video.destroyed?
  end

  private

  def set_videoable
    unless Video::VIDEOABLES.include?(params[:videoable_type])
      render_error('wrong videoable type')
      return
    end

    @videoable = params[:videoable_type].constantize.find params[:videoable_id]
  end

  def set_video
    @video = @videoable.videos.find params[:id]

    authorize @video
  end
end