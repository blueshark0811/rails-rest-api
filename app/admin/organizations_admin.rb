Trestle.resource(:organizations) do
  menu do
    item :organizations, icon: 'fa fa-building'
  end

  routes do
    post :add_user, on: :member
    delete :delete_user, on: :member
    get :search, on: :collection
  end

  search do |query|
    if query
      Organization.where("title ILIKE ?", "%#{query}%")
    else
      Organization.all
    end
  end

  table do
    column :title
    column(:url) do |organization|
      link_to(organization.url, organization.url)
    end
    column :created_at, align: :center

    actions
  end

  form do |organization|
    tab :base do
      text_field :title
      file_field :logo
      if organization.logo?
        row do
          col(sm: 6) { image_tag organization.logo_url(:display) }
        end
      end
      editor :description
      text_field :subdomain
      text_field :domain
    end

    tab :contacts do
      select :country_id, Country.all
      select :state_id, State.all
      text_field :address
      text_field :zip_code
      text_field :phone
      text_field :email
      text_field :website
    end

    tab :other do
      select :language, MODELS['organization']['languages'].invert
      text_field :notification_email
      text_field :display_name
      select :display_type, MODELS['organization']['display_types'].invert
    end

    tab :admins do
      unless organization.new_record?
        row do
          col(sm: 3) do
            content_tag :div, class: "form-group" do
              select_tag(
                :user_id,
                options_from_collection_for_select(User.all, :id, :name),
                data: { enable_select2: true },
                class: 'form-control',
                id: 'organization-user'
              )
            end
          end

          col(sm: 3) do
            link_to(
              'Add user',
              '#',
              'data-url': add_user_organizations_admin_path(organization),
              class: "btn btn-success",
              onclick: 'addUserToOrganization(this)'
            )
          end
        end

        table collection: -> { organization.admins }, admin: :users do
          column(:name) do |user|
            link_to user.name, edit_users_admin_path(user)
          end
          column :actions do |user|
            link_to(
              'Delete from organization',
              delete_user_organizations_admin_path(organization, user_id: user.id),
              method: :delete,
              class: "btn btn-danger",
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

    tab 'Add-ons' do
      unless organization.new_record?
        row do
          col(sm: 3) do
            content_tag :div, class: 'form-group' do
              select_tag(
                :course_id,
                options_from_collection_for_select(Addon.all, :id, :title),
                data: { enable_select2: true },
                class: 'form-control',
                id: 'organization-addon'
              )
            end
          end

          col(sm: 3) do
            link_to(
              'Add to add-on',
              '#',
              'data-url': add_to_organization_addons_admin_path(
                0,
                organization_id: organization.id,
                redirect: edit_organizations_admin_path(organization, anchor: '!tab-Add-ons')
              ),
              class: 'btn btn-success',
              onclick: 'addAddonToOrganization(this)'
            )
          end
        end

        table collection: -> { organization.addons }, admin: :addons do
          column :title do |addon|
            link_to addon.title, edit_addons_admin_path(addon)
          end

          column :actions do |addon|
            link_to(
              'Delete organization from addon',
              delete_from_organization_addons_admin_path(
                addon,
                organization_id: organization.id,
                redirect: edit_organizations_admin_path(organization, anchor: '!tab-Add-ons')
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

  controller do
    def search
      render json: Organization.where('title ILIKE ?', "%#{params[:term]}%")
        .map { |l| { value: l.title, id: l.id } }.to_json
    end

    def delete_user
      OrganizationUser.find_by!(organization_id: params[:id], user_id: params[:user_id]).destroy
      flash[:message] = "User deleted from organization"

      redirect_to(params[:redirect]) and return if params[:redirect]

      redirect_to edit_organizations_admin_path(params[:id], anchor: '!tab-admins')
    end

    def add_user
      ou = OrganizationUser.find_or_create_by(organization_id: params[:id], user_id: params[:user_id])

      unless ou.admin?
        ou.admin!
      end

      flash[:message] = "User added to organization"

      redirect_to(params[:redirect]) and return if params[:redirect]

      redirect_to edit_organizations_admin_path(params[:id], anchor: '!tab-admins')
    end
  end
end
