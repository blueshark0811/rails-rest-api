Trestle.resource(:attachments) do
  menu do
    item :attachments, icon: 'fa fa-star', priority: 3, group: :attachments
  end

  controller do
    def destroy
      Attachment.find(params[:id]).destroy
      respond_to do |format|
        format.json{  head :ok }
        format.html { redirect_to attachments_admin_index_path }
      end
    end

     def create
      @attachment = current_user.attachments.create params[:attachment].permit!
      render json: { attachment: { id: @attachment.id } }
     end
  end
end
