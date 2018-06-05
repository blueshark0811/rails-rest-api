Trestle.resource(:activities, read_only: true) do
  filter name: :organization_id, remote_collection_url: '/admin/organizations/search', label: 'Organization'

  menu do
    item :activities, icon: 'fa fa-bell', priority: 2, group: :activity
  end

  scope :recent, default: true

  search do |query, params|
    sc = if params[:organization_id].presence
      Activity.where(organization_id: params[:organization_id])
    else
      Activity.all
    end

    sc
  end

  table autolink: false do
    column :user
    column :message do |a|
      raw a.plain_message
    end
    # column :eventable

    column :organization
    column :group
    column :course
    column :lesson
    column :task
    
    column :created_at
  end
end
