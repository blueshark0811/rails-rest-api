module Users
  module Api
    extend ActiveSupport::Concern

    module ClassMethods
      include ApiAttributes

      # def api_fields_minus_for_update
      #   api_fields_minus_for_create
      # end

      # def api_fields_plus_for_update
      #   api_fields_plus_for_create
      # end

      # def api_fields_minus_for_create
      #   %w(created_at updated_at id)
      # end

      # def api_fields_plus_for_create
      #   %w()
      # end
    end
  end
end