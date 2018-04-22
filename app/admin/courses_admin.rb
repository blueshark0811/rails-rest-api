Trestle.resource(:courses) do
  menu do
    item :courses, icon: 'fa fa-tasks', priority: 1
  end

  table do
    column :title
    column :organization
    column :created_at, align: :center
    actions
  end


  form do |course|
    text_field :title
    editor :description
    file_field :image

    select :organization_id, Organization.all.map{|o|[o.title, o.id]}
    select :user_id, User.super_admin, label: 'Author'
  end
end
