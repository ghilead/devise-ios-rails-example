class API < Grape::API
  format :json
  formatter :json, Grape::Formatter::ActiveModelSerializers
  logger Rails.logger
  def self.logger
    @logger ||= Rails.logger
  end

  helpers do
    include SessionsHelper

    def invalid_login_attempt
      error!('Error with your login or password', 401)
    end

    def current_user
      @current_user ||= validate_session!(params[:sessionToken])
    end
  end

  use APILogger
  mount V1::Base

  add_swagger_documentation(
    api_version: 'v1'
  )
end
