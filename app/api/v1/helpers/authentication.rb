module V1
  module Helpers
    module Authentication
      def current_user
        @current_user ||= authenticate
      end

      def authenticate
        User.where(authentication_token: token, email: email).take
      end

      def email
        params[:userEmail] || headers['X-User-Email']
      end

      def token
        params[:userToken] || headers['X-User-Token']
      end

      def authorize!
        raise(UnauthorizedError) if token.nil? && email.nil?
        raise(ForbiddenError) if current_user.nil?
        current_user
      end
    end
  end
end
