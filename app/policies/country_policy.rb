class CountryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def api_base_attributes
    return @api_base_attributes if @api_base_attributes

    @api_base_attributes = super

    @api_base_attributes.delete(:created_at)
    @api_base_attributes.delete(:updated_at)

    @api_base_attributes
  end
end