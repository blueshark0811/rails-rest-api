class AddFieldsToOrganizations < ActiveRecord::Migration[5.1]
  def change
    add_column :organizations, :description, :text
    add_column :organizations, :logo, :string
    add_column :organizations, :address, :string
    add_column :organizations, :zip_code, :string
    add_column :organizations, :website, :string
    add_column :organizations, :email, :string
    add_column :organizations, :phone, :string
    add_column :organizations, :language, :string
    add_column :organizations, :notification_settings, :jsonb, default: {notification_email: nil}
    add_column :organizations, :display_settings, :jsonb, default: {display_name: nil, display_type: 'display_name'}

    add_reference :organizations, :country, foreign_key: true
    add_reference :organizations, :state, foreign_key: true
  end
end
