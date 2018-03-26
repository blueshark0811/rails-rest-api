class Api::V1::CitiesController < Api::V1::ApiController
  skip_before_action :authenticate_user!
  skip_before_action :authenticate_organization!
  before_action :set_city, except: %i[index]

  def index
    order = { id: sort_flag }

    where = {}

    @cities = City.order(order)

    if params[:country_id]
      @cities = @cities.joins(:country)
      where[:countries] = { id: params[:country_id] }
    end

    where[:state_id] = params[:state_id] if params[:state_id]

    render_result @cities.where(where).page(current_page).per(current_count)
  end

  def show
    render_result @city
  end

  private

  def set_city
    @city = City.find params[:id]
  end
end
