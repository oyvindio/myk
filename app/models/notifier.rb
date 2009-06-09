class Notifier < ActionMailer::Base
  default_url_options[:host] = APP_CONF['mail']['domain']

  def password_reset_instructions(user)
    subject       'pwd_reset_instruction'
    from          "#{APP_CONF['settings']['name']} Notifier <#{APP_CONF['mail']['sender']}>"
    recipients    user.email
    sent_on       Time.now
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end
end
