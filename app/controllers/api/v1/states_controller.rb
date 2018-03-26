class Api::V1::StatesController < Api::V1::ApiController
  skip_before_action :authenticate_user!
  skip_before_action :authenticate_organization!
  before_action :set_state, except: %i[index]

  def index
    order = { id: sort_flag }

    where = {}

    where[:country_id] = params[:country_id] if params[:country_id]

    @states = State.where(where).order(order)

    render_result @states.page(current_page).per(current_count)
  end

  def show
    render_result @state
  end

  private

  def set_state
    @state = State.find params[:id]
  end
end
