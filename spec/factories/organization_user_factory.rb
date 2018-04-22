FactoryBot.define do
  factory :organization_user do
    user
    organization

    activity_settings {}
    exclude_students_ids []
    files_controll_enabled true
    messanger_access_enabled true
    role 'admin'
    status OrganizationUser.statuses.first.first
  end
end
