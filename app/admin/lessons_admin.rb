Trestle.resource(:lessons) do
  menu do
    item :lessons, icon: 'fa fa-pencil', group: :courses, priority: 1
  end

  table do
    column :title
    column :status
    column :course
    column :created_at, align: :center
    actions
  end

  form do |lesson|
    text_field :title
    editor :description
    select :status, MODELS['lesson']['statuses'].invert
    
    select :course_id, Course.all

    if lesson.new_record?
      hidden_field :user_id, value: current_user.id
    end
  end
end
