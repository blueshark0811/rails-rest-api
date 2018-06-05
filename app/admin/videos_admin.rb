Trestle.resource(:videos) do
  menu do
    item :videos, icon: 'fa fa-star', priority: 3, group: :attachments
  end

  routes do
    get :get_token, on: :collection
  end

  controller do
    def destroy
      Video.find(params[:id]).destroy
      respond_to do |format|
        format.json{  head :ok }
        format.html { redirect_to videos_admin_index_path }
      end
    end

    def get_token
      unless Video::VIDEOABLES.include?(params[:videoable_type])
        render(json: { error: 'wrong videoable type' })
        return
      end

      @videoable = params[:videoable_type].constantize.find params[:videoable_id]

      @video = @videoable.videos.new(
        user_id: current_user.id,
        mode: 'sproutvideo'
      )

      @video.save

      render json: { id: @video.id, token: @video.token }
    end
  end
end
