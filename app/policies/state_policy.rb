class StatePolicy < ApplicationPolicy
  def permitted_attributes
    %i[code country_id name]
  end
end
