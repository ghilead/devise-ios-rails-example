class API < Grape::API
  use APILogger
  logger Rails.logger
  def self.logger
    @logger ||= Rails.logger
  end

  format :json
  mount V1::Base
end
