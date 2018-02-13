# Load the Rails application.
require_relative 'application'

require "#{Rails.root}/lib/config"

APP_CONFIG = Config.get('app_config')
MODELS = Config.get('model', false)

# Initialize the Rails application.
Rails.application.initialize!
