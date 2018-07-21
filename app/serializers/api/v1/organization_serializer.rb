class Api::V1::OrganizationSerializer < BaseSerializer
  include ApiSerializer

  %i[notification_settings display_settings created_at updated_at id country_id state_id].each do |field|
    define_method field do
      return ActiveModel::FieldUpgrade::ATTR_NOT_ACCEPTABLE if current_role != 'admin'

      object.send field
    end
  end

  %i[display_settings display_name display_type].each do |field|
    define_method field do
      object.send field
    end
  end
end
