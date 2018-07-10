class ApplicationMailer < ActionMailer::Base
  default from: APP_CONFIG['from_email']
  layout 'mailer'
end
