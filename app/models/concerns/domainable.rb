module Domainable
  extend ActiveSupport::Concern

  class_methods do
    def domainable(*fields)
      fields.each do |field|
        field = { field: field } unless field.is_a?(Hash)
        validates(field[:field], presence: true) if field.fetch(:required, true)

        if REGEXP[field[:field]]
          validates field[:field], format: REGEXP[field[:field]], allow_blank: true
        end

        validate_method = "validate_#{field[:field]}".to_sym

        validate(validate_method)

        define_method validate_method do
          return if !changes[field[:field].to_s] || send(field[:field]).blank?

          scp = self.class.where(field[:field] => send(field[:field]))

          scp = scp.where.not(id: id) unless new_record?

          errors.add(field[:field], :taken) if scp.exists?
        end
      end
    end
  end
end
