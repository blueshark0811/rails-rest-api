Rails.application.config.action_mailer.smtp_settings = {enable_starttls_auto: false}
Rails.application.config.action_mailer.default_url_options = { host: APP_CONFIG['host'] }
unless Rails.env.test?
  Rails.application.config.action_mailer.delivery_method = :smtp
  Rails.application.config.action_mailer.smtp_settings = {
    user_name: ENV['SENDGRID_USER'],
    password: ENV['SENDGRID_PASSWORD'],
    domain: APP_CONFIG['host'],
    address: 'smtp.sendgrid.net',
    port: 587,
    authentication: :plain,
    enable_starttls_auto: true
  }
end
