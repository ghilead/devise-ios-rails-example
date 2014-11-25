require 'rollbar/rails'

Rollbar.configure do |config|
  if Rails.env.test? || Rails.env.development?
    config.enabled = false
  else
    config.access_token = ENV.fetch('ROLLBAR_SERVER_TOKEN') { 'not_valid_token' }
    config.exception_level_filters.merge!(
      'ActionController::RoutingError' => 'ignore'
    )

    config.person_username_method = 'email'
  end
end
