class CityPolicy < ApplicationPolicy
  def permitted_attributes
    %i[name state_id]
  end
end
