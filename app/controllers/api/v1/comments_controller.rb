class Api::V1::CommentsController < Api::V1::ApiController
  before_action :set_commentable
  before_action :set_comment, except: %i[index create]

  def index
    @comments = bparams(:only_roots) ? scope.root_comments : scope.tree(params[:root_id])

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
    @comment = scope.new user_id: current_user.id
    # authorize @comment as we have validation of commentable

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

    authorize @commentable, "comments_#{params[:action]}?"
  end

  def set_comment
    @comment = scope.find params[:id]

    authorize @comment
  end

  def scope
    @commentable.comments
  end
end
