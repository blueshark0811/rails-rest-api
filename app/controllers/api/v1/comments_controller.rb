class Api::V1::CommentsController < Api::V1::ApiController
  before_action :set_commentable
  before_action :set_comment, except: %i[index create]

  def index
    authorize @commentable, :comments_index?

    @comments = if bparams(:only_roots)
      @commentable.comments.root_comments
    else
      @commentable.comments.tree(params[:root_id])
    end

    render_result @comments.page(current_page).per(current_count)
  end

  def update
    if @comment.update_attributes permitted_attributes(@comment)
      render_result(@comment) else render_error(@comment)
    end
  end

  def destroy
    @comment.destroy

    render_result success: @comment.destroyed?
  end

  def create
    @comment = @commentable.comments.new user_id: current_user.id
    authorize @comment

    if @comment.update_attributes permitted_attributes(@comment)
      render_result(@comment) else render_error(@comment)
    end
  end

  private

  def set_commentable
    unless Comment::COMMENTABLES.include?(params[:commentable_type])
      render_error('wrong commentable type')
      return
    end

    @commentable = params[:commentable_type].constantize.find params[:commentable_id]
  end

  def set_comment
    @comment = @commentable.comments.find params[:id]

    authorize @comment
  end
end
