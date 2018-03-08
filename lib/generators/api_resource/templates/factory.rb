FactoryBot.define do
  factory :<%= singular_name %> do
    <% @associations.each do |association| %>
    <%= association.name %><% end %>
    <% @permitted_attributes.each do |attribute| %>
    <%= attribute.to_s + ' ' + get_attribute_faker(attribute) %><% end %>
  end
end
