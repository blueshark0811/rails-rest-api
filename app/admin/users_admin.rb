Trestle.resource(:users) do
  menu do
    item :users, icon: 'fa fa-users'
  end

  search do |query|
    User.search query.presence || '*', fields: User::SEARCH_FIELDS, match: :word_start
  end

  table do
    column :id
    column :first_name
    column :last_name
    column :email
    column :admin_role

    column :last_sign_in_at
    column :last_sign_in_ip

    column :country
    column :created_at, align: :center

    actions
  end

  form do |user|
    tab :base do
      text_field :first_name
      text_field :last_name
      text_field :email
      text_field :phone_number
      date_field :date_of_birth
      file_field :avatar
      if user.avatar?
        row do
          col(sm: 6) { image_tag user.avatar_url(:middle) }
        end
      end
    end

    tab :address do
      select :country_id, Country.all
      select :state_id, State.all
      text_field :address
      text_field :zip_code
    end

    tab :status do
      select :admin_role, MODELS['user']['admin_roles'].invert
      select :status, MODELS['user']['statuses'].invert
    end

    tab :credentials do
      text_field :password, label: 'New password', help: "leave blank if you don't want to change it"
    end

    tab :organizations do
      unless user.new_record?
        row do
          col(sm: 3) do
            content_tag :div, class: 'form-group' do
              select_tag(
                :organization_id,
                options_from_collection_for_select(Organization.all, :id, :title),
                data: { enable_select2: true },
                class: 'form-control',
                id: 'organization-user'
              )
            end
          end

          col(sm: 3) do
            link_to(
              'Add organization',
              '#',
              'data-url': add_user_organizations_admin_path(
                0,
                user_id: user.id,
                redirect: edit_users_admin_path(user, anchor: '!tab-organizations')
              ),
              class: 'btn btn-success',
              onclick: 'addOrganizationToUser(this)'
            )
          end
        end

        table collection: -> { user.organizations }, admin: :organizations do
          column :title do |organization|
            link_to organization.title, edit_organizations_admin_path(organization)
          end

          column :actions do |organization|
            link_to(
              'Delete organization from user',
              delete_user_organizations_admin_path(
                organization,
                user_id: user.id,
                redirect: edit_users_admin_path(user, anchor: '!tab-organizations')
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
    before_action do
      if params[:user] && params[:user][:password] && params[:user][:password].blank?
        params[:user].delete :password
      end
    end
  end
end
