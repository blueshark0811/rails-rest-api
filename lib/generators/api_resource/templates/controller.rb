class Api::V1::<%= class_name.pluralize %>Controller < Api::V1::ApiController
  before_action :set_<%= singular_name %>, except: %i[index create]

  def index
    order = { <%= @sort_field %>: sort_flag }

    where = policy_condition(<%= class_name %>)
<% if @searchkick %>
    @<%= plural_name %> = <%= class_name %>.search params[:term] || '*',
      where: where,
      order: order,
      page: current_page,
      per_page: current_count,
      fields: <%= class_name %>::SEARCH_FIELDS,
      match: :word_start
<% else %>
    @<%= plural_name %> = policy_scope(<%= class_name %>).where(where).order(order)
      .page(current_page).per(current_count)
<% end %>

    render_result @<%= plural_name %>
  end

  def show
    render_result @<%= singular_name %>
  end

  def update
    if @<%= singular_name %>.update_attributes permitted_attributes(@<%= singular_name %>)
      render_result(@<%= singular_name %>) else render_error(@<%= singular_name %>)
    end
  end

  def destroy
    @<%= singular_name %>.destroy

    render_result success: @<%= singular_name %>.destroyed?
  end

  def create
    @<%= singular_name %> = <%= class_name %>.new

    authorize @<%= singular_name %>

    if @<%= singular_name %>.update permitted_attributes(@<%= singular_name %>)
      render_result(@<%= singular_name %>) else render_error(@<%= singular_name %>)
    end
  end

  private

  def set_<%= singular_name %>
    @<%= singular_name %> = <%= class_name %>.find params[:id]

    authorize @<%= singular_name %>
  end
end
