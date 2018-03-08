class Api::V1::<%= class_name %>Serializer < BaseSerializer
  include ApiSerializer
  <% @associations.each do |association| %>
  <%= association.macro.to_s + ' :' + association.name.to_s %><% end %>
end
