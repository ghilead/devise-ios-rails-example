class API < Grape::API
  use APILogger
  logger Rails.logger
  def self.logger
    @logger ||= Rails.logger
  end
end
