Trestle.resource(:lessons) do
  filter name: :course_id, remote_collection_url: '/admin/courses/search', label: 'Course'
  filter name: :status, collection: Lesson.statuses.keys

  search do |query, params|
    sc = Lesson.where('title ILIKE ?', "%#{params[:q]}%")

    sc = sc.where(course_id: params[:course_id]) if params[:course_id].presence
    sc = sc.where(status: params[:status]) if params[:status].presence

    sc
  end

  routes do
    get :search, on: :collection
  end

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

  controller do
    def search
      render json: Lesson.where('title ILIKE ?', "%#{params[:term]}%")
        .map { |l| { value: l.title, id: l.id } }.to_json
    end
  end
end
