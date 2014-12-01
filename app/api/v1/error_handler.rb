module V1
  module ErrorHandler
    extend ActiveSupport::Concern

    included do
      error_formatter :json, ErrorFormatter

      rescue_from ActiveRecord::RecordNotFound do |e|
        error_response(message: e.message, status: 404)
      end

      rescue_from Grape::Exceptions::ValidationErrors do |e|
        error_response(message: e.message, status: e.status)
      end

      rescue_from :all do |e|
        if Rails.env.development? || Rails.env.test?
          raise e
        else
          error_response(message: "Internal server error", status: 500)
        end
      end
    end
  end
end
