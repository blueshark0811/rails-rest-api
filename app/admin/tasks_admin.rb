Trestle.resource(:tasks) do
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

  form do |task|
    select :action_type, MODELS['task']['action_types'].invert
    editor :description
    select :lesson_id, Lesson.all

    if task.new_record?
      hidden_field :user_id, value: current_user.id
    end
  end
end
