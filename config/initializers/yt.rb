Yt.configure do |config|
  config.api_key = APP_CONFIG.dig(:google_api, :key)
end
