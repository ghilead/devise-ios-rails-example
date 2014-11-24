require 'rollbar/rails'

Rollbar.configure do |config|
  config.access_token = ENV['ROLLBAR_SERVER_TOKEN']
  config.exception_level_filters.merge!(
     'ActionController::RoutingError' => 'ignore'
   )


  if Rails.env.test? || Rails.env.development?
    config.enabled = false
  end

  config.person_username_method = "email"
end
