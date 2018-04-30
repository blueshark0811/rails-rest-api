Trestle.resource(:addons) do
  menu do
    item :addons, icon: "fa fa-puzzle-piece", label: 'Add-ons', priority: 1
  end

  routes do
    post :add_to_organization, on: :member
    delete :delete_from_organization, on: :member

    post :add_course, on: :member
    delete :delete_course, on: :member
  end

  controller do
    def delete_course
      AddonCourse.find_by!(course_id: params[:course_id], addon_id: params[:id]).destroy
      flash[:message] = 'Course deleted from addon'

      redirect_to(params[:redirect]) and return if params[:redirect]

      redirect_to edit_addons_admin_path(params[:id], anchor: '!tab-courses')
    end

    def add_course
      AddonCourse.find_or_create_by(course_id: params[:course_id], addon_id: params[:id])

      flash[:message] = 'Course added to addon'

      redirect_to(params[:redirect]) and return if params[:redirect]

      redirect_to edit_addons_admin_path(params[:id], anchor: '!tab-courses')
    end

    def delete_from_organization
      AddonOrganization.find_by!(organization_id: params[:organization_id], addon_id: params[:id]).destroy
      flash[:message] = 'Addon deleted from organization'

      redirect_to(params[:redirect]) and return if params[:redirect]

      redirect_to edit_addons_admin_path(params[:id], anchor: '!tab-organizations')
    end

    def add_to_organization
      AddonOrganization.find_or_create_by(organization_id: params[:organization_id], addon_id: params[:id])

      flash[:message] = 'Addon added to organization'

      redirect_to(params[:redirect]) and return if params[:redirect]

      redirect_to edit_addons_admin_path(params[:id], anchor: '!tab-organizations')
    end
  end

  table do
    column :title
    column :course_count do |addon|
      addon.courses.count
    end
    column :organization_count do |addon|
      addon.organizations.count
    end
    column :created_at, align: :center
    actions
  end

  form do |addon|
    tab :base do
      text_field :title
      text_field :description
    end

    tab :courses do
      unless addon.new_record?
        row do
          col(sm: 3) do
            content_tag :div, class: 'form-group' do
              select_tag(
                :course_id,
                options_from_collection_for_select(Course.all, :id, :title),
                data: { enable_select2: true },
                class: 'form-control',
                id: 'addon-course'
              )
            end
          end

          col(sm: 3) do
            link_to(
              'Add course',
              '#',
              'data-url': add_course_addons_admin_path(
                addon.id,
                redirect: edit_addons_admin_path(addon, anchor: '!tab-courses')
              ),
              class: 'btn btn-success',
              onclick: 'addCourseToAddon(this)'
            )
          end
        end

        table collection: -> { addon.courses }, admin: :courses do
          column :title do |course|
            link_to course.title, edit_courses_admin_path(course)
          end

          column :actions do |course|
            link_to(
              'Delete course from addon',
              delete_course_addons_admin_path(
                addon,
                course_id: course.id,
                redirect: edit_addons_admin_path(addon, anchor: '!tab-courses')
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

    tab :organizations do
      unless addon.new_record?
        row do
          col(sm: 3) do
            content_tag :div, class: 'form-group' do
              select_tag(
                :organization_id,
                options_from_collection_for_select(Organization.all, :id, :title),
                data: { enable_select2: true },
                class: 'form-control',
                id: 'organization-addon'
              )
            end
          end

          col(sm: 3) do
            link_to(
              'Add to organization',
              '#',
              'data-url': add_to_organization_addons_admin_path(
                addon.id,
                redirect: edit_addons_admin_path(addon, anchor: '!tab-organizations')
              ),
              class: 'btn btn-success',
              onclick: 'addOrganizationToAddon(this)'
            )
          end
        end

        table collection: -> { addon.organizations }, admin: :organizations do
          column :title do |organization|
            link_to organization.title, edit_organizations_admin_path(organization)
          end

          column :actions do |organization|
            link_to(
              'Delete addon from organization',
              delete_from_organization_addons_admin_path(
                addon,
                organization_id: organization.id,
                redirect: edit_addons_admin_path(addon, anchor: '!tab-organizations')
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
