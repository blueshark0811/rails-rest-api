# frozen_string_literal: true

class Api::V1::AttachmentsController < Api::V1::ApiController
  before_action :set_attachmentable
  before_action :set_attachment, except: %i[index create new s3_data]

  def index
    order = if Attachment::SORT_FIELDS.include?(params[:sort_field])
              { params[:sort_field] => sort_flag }
            else
              { file_name: sort_flag }
            end

    @attachments = Attachment.search params[:term] || '*',
      where: {
        attachmentable_id: @attachmentable.id,
        attachmentable_type: @attachmentable.class.name
      },
      order: order,
      page: current_page,
      per_page: current_count,
      match: :word_start

    render_result @attachments
  end

  def show
    render_result @attachment
  end

  def new
    # @uploader = @attachmentable.attachments.new.data
    # @uploader.success_action_redirect = false
    # render_result(
    #   direct_fog_url: @uploader.direct_fog_url,
    #   key: @uploader.key,
    #   acl: @uploader.acl,
    #   policy: @uploader.policy,
    #   'x-amz-algorithm': @uploader.algorithm,
    #   'x-amz-credential': @uploader.credential,
    #   'x-amz-date': @uploader.date,
    #   'x-amz-signature': @uploader.signature,
    #   'success_action_redirect': @uploader.success_action_redirect
    # )

    @s3_direct_post = S3_BUCKET.presigned_post(
      key: "uploads/#{SecureRandom.uuid}/${filename}",
      success_action_status: '201',
      acl: 'private'
    )

    render_result(
      fields: @s3_direct_post.fields,
      url: @s3_direct_post.url,
      host: URI.parse(@s3_direct_post.url).host
    )
  end

  def create
    @attachment = @attachmentable.attachments.new(
      user_id: current_user.id,
      organization_id: current_organization.id
    )

   # authorize @attachment as we validate attachmentable

    if @attachment.update permitted_attributes(@attachment)
      render_result @attachment
    else
      render_error @attachment
    end
  end

  def update
    if @attachment.update permitted_attributes(@attachment)
      render_result(@attachment) else render_error(@attachment)
    end
  end

  def destroy
    @attachment.destroy

    render_result success: @attachment.destroyed?
  end

  private

  def set_attachmentable
    unless Attachment::ATTACHMENTABLES.include?(params[:attachmentable_type])
      render_error('wrong attachmentable type')
      return
    end

    @attachmentable = params[:attachmentable_type].constantize.find params[:attachmentable_id]

    authorize @attachmentable, "attachments_#{params[:action]}?"
  end

  def set_attachment
    @attachment = @attachmentable.attachments.find params[:id]

    authorize @attachment
  end
end
