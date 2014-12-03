module V1
  module Helpers
    module Authentication
      def current_user
        @current_user ||= authenticate
      end

      def authenticate
        User.find_by_authentication_token(token)
      end

      def token
        params[:authentication_token] || headers['X-Authentication-Token']
      end

      def authorize!
        raise(UnauthorizedError) if token.nil?
        raise(ForbiddenError) if current_user.nil?
        current_user
      end
    end
  end
end
