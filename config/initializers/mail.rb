# Email settings
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {

  :address => APP_CONF['mail']['address'],
  :port => APP_CONF['mail']['port'],
  :domain => APP_CONF['mail']['domain'],
  :authentication => APP_CONF['mail']['authentication'],
  :user_name => APP_CONF['mail']['user_name'],
  :password => APP_CONF['mail']['password']  
}
