class Api::V1::CountriesController < Api::V1::ApiController
  skip_before_action :authenticate_user!
  skip_before_action :authenticate_organization!
  before_action :set_country, except: %i[index]

  def index
    order = { id: sort_flag }

    where = {}

    @countries = Country.where(where).order(order)

    render_result @countries.page(current_page).per(current_count)
  end

  def show
    render_result @country
  end

  private

  def set_country
    @country = Country.find params[:id]
  end
end
