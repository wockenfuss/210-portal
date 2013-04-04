password = Rails.env.production? ? ENV['MGKEY'] : ENV['MAILGUN']
ActionMailer::Base.smtp_settings = {
  :port           => 587, 
  :address        => 'smtp.mailgun.org',
  :user_name      => 'postmaster@coughenour.mailgun.org',
  :password       => password,
  :domain         => 'coughenour.mailgun.org',
  :authentication => :plain,
  :enable_starttls_auto => true
}
ActionMailer::Base.delivery_method = :smtp
