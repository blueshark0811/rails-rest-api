class Api::V1::AppSettingsController < Api::V1::ApiController
	skip_before_action :authenticate_user!

	def index
		render_result AppSetting.last
	end
end