class API < Grape::API
  use APILogger
  logger Rails.logger
  def self.logger
    @logger ||= Rails.logger
  end

  format :json
  formatter :json, Grape::Formatter::ActiveModelSerializers
  mount V1::Base
  add_swagger_documentation(api_version: 'v1')
end
