module V1
  module ErrorHandler
    extend ActiveSupport::Concern

    included do
      error_formatter :json, ErrorFormatter

      rescue_from ActiveRecord::RecordNotFound do |e|
        error = Error.new(
          message: e.message,
          status: 404,
          code: 0
        )
        error_response(message: error, status: 404)
      end

      rescue_from ActiveRecord::RecordInvalid do |e|
        error = Error.new(
          message: e.message,
          status: 422,
          code: 0
        )
        error_response(message: error, status: 422)
      end

      rescue_from Grape::Exceptions::ValidationErrors do |e|
        error = Error.new(
          message: e.message,
          status: e.status,
          code: 0
        )
        error_response(message: error, status: e.status)
      end

      rescue_from :all do |e|
        if Rails.env.development? || Rails.env.test?
          raise e
        else
          error_response(message: InternalServerError.new, status: 500)
        end
      end
    end
  end
end
