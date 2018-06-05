Trestle.resource(:tasks) do
  filter name: :lesson_id, remote_collection_url: '/admin/lessons/search', label: 'Lesson'
  filter name: :action_type, collection: Task.action_types.keys, label: 'Action Type'

  routes do
    get :search, on: :collection
  end

  search do |query, params|
    sc = Task.where('description ILIKE ?', "%#{query}%")

    sc = sc.where(lesson_id: params[:lesson_id]) if params[:lesson_id].presence
    sc = sc.where(action_type: params[:action_type]) if params[:action_type].presence

    sc
  end

  menu do
    item :tasks, icon: 'fa fa-pencil', group: :courses, priority: 2
  end

  table do
    column :action_type
    # column :description do |task|
    #   raw task.description
    # end
    column :lesson
    column :created_at, align: :center
    actions
  end

  form class: 'dropzone' do |task|
    tab :base do
      select :action_type, MODELS['task']['action_types'].invert
      editor :description
      select :lesson_id, Lesson.all

      if task.new_record?
        hidden_field :user_id, value: current_user.id
      end
    end

    tab :attachments do
      render partial: 'admin/attachments/attachments', locals: { object: task }
    end

    tab :video do
      render partial: 'admin/videos/videos', locals: { object: task }
    end
  end
end
