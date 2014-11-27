module V1
  module Helpers
    module Authentication
      def current_user
        warden.user
      end

      def authenticated_user
        authenticated
        error!('Forbidden', 403) unless current_user
      end

      private

      def warden
        env.fetch('warden')
      end

      def authenticated
        error!('Unauthorized', 401) unless warden.authenticated?
      end
    end
  end
end
