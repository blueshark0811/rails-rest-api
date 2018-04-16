class AddActivitySettingsToOrganizationUsers < ActiveRecord::Migration[5.1]
  def change
    add_column(
      :organization_users, 
      :activity_settings, 
      :jsonb, 
      default: { activity_course_ids: [], activity_student_ids: [] }
    )
  end
end
