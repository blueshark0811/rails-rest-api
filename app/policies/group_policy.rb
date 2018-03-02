# frozen_string_literal: true

class GroupPolicy < OrganizationEntityPolicy
  def permitted_attributes
    %i[description status title user_limit visibility]
  end
end
