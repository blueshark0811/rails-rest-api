Trestle.resource(:courses) do
  filter name: :organization_id, remote_collection_url: '/admin/organizations/search', label: 'Organization'

  menu do
    item :courses, icon: 'fa fa-tasks', group: :courses, priority: 0
  end

  routes do
    get :search, on: :collection
  end

  search do |query, params|
    sc = if params[:organization_id].presence
      @ornagization = Organization.find params[:organization_id]
      @ornagization.courses
    else
      Course.all
    end

    sc = sc.where('title ILIKE ?', "%#{query}%")

    sc
  end

  controller do
    def search
      render json: Course.where('title ILIKE ?', "%#{params[:term]}%")
        .map { |l| { value: l.title, id: l.id } }.to_json
    end
  end

  table do
    column :title
    column :organization

    column :addons_count do |course|
      course.addons.count
    end
    column 'Organizations through Add-ons' do |course|
      course.organizations_through_addons.count
    end
    column :lesons_count do |course|
      course.lessons.count
    end

    column :created_at, align: :center
    actions
  end

  form do |course|
    tab :base do
      text_field :title
      editor :description
      file_field :image
      select :organization_id, Organization.all, help: 'set if course is not for add-ons(created by admin of org)'

      if course.new_record?
        hidden_field :user_id, value: current_user.id
      end
      # select :user_id, User.super_admin, label: 'Author'
    end

    tab 'Add-ons' do
      unless course.new_record?
        row do
          col(sm: 3) do
            content_tag :div, class: 'form-group' do
              select_tag(
                :course_id,
                options_from_collection_for_select(Addon.all, :id, :title),
                data: { enable_select2: true },
                class: 'form-control',
                id: 'course-addon'
              )
            end
          end

          col(sm: 3) do
            link_to(
              'Add to add-on',
              '#',
              'data-url': add_course_addons_admin_path(
                0,
                course_id: course.id,
                redirect: edit_courses_admin_path(course, anchor: '!tab-Add-ons')
              ),
              class: 'btn btn-success',
              onclick: 'addAddonToCourse(this)'
            )
          end
        end

        table collection: -> { course.addons }, admin: :addons do
          column :title do |addon|
            link_to addon.title, edit_addons_admin_path(addon)
          end

          column :actions do |addon|
            link_to(
              'Delete course from addon',
              delete_course_addons_admin_path(
                addon,
                course_id: course.id,
                redirect: edit_courses_admin_path(course, anchor: '!tab-Add-ons')
              ),
              method: :delete,
              class: 'btn btn-danger',
              'data-confirm': 'Are you sure?'
            )
          end
        end
      else
        row do
          'Available at edit mode. Please create instance and come back here.'
        end
      end
    end
  end
end
