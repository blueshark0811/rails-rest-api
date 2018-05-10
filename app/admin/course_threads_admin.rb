Trestle.resource(:course_threads) do
  filter name: :organization_id, remote_collection_url: '/admin/organizations/search', label: 'Organization'

  search do |query, params|
    sc = if params[:organization_id].presence
      CourseThread.joins(:organization).where(organizations: {id: params[:organization_id]})
    else
      CourseThread.all
    end

    sc = sc.where('course_threads.title ILIKE ?', "%#{query}%")

    sc
  end

  menu do
    item :course_threads, icon: 'fa fa-comments', priority: 4, group: :activity
  end

  table do
    column :user
    column :title
    column :course

    column :comments_count

    column :last_activity_at
    column :created_at, align: :center
    actions
  end

  form do |course_thread|
    text_field :title
  end
end
