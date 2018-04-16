class Api::V1::ActivitySerializer < BaseSerializer
  include ApiSerializer
  
  belongs_to :eventable
  belongs_to :notifiable

  %i[lesson task course group user].each do |field|
    belongs_to field

    define_method field do
      return ActiveModel::FieldUpgrade::ATTR_NOT_ACCEPTABLE if current_role == 'student'

      object.send field
    end
  end
end
