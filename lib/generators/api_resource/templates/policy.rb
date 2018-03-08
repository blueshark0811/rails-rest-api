class <%= class_name %>Policy < ApplicationPolicy
  def permitted_attributes
    %i[<%= @permitted_attributes.join ' ' %>]
  end
end
