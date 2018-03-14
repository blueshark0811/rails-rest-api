Rails.application.config.action_mailer.default_url_options = { host: APP_CONFIG['host'] }
Rails.application.config.action_mailer.smtp_settings = { enable_starttls_auto: false }
