Trestle.resource(:comments) do
  # filter name: :organization_id, remote_collection_url: '/admin/organizations/search', label: 'Organization'

  search do |query, params|
    # sc = if params[:organization_id]
    #   Comment.joins(:organization).where(organization: {id: params[:organization_id]})
    # else
      Comment.all
    # end

    sc = Comment.where('body ILIKE ?', "%#{query}%")

    sc
  end

  menu do
    item :comments, icon: 'fa fa-comments', priority: 3, group: :activity
  end

  table do
    column :user
    column :body
    column :place do |comment|
      # res = comment.commentable_type
      # if comment.commentable_type == 'TaskUser'
      #   res += link_to(comment.commentable.description, root_url(host: comment.commentable.organization.host))
      # end

      # res

      "#{comment.commentable_type}(#{comment.commentable.try(:title) || comment.commentable.try(:description)})"
    end
    column :created_at
  end

  form do |comment|
    text_area :body
  end
end
