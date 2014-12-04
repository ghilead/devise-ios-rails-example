module Grape
  class API
    def self.require_authentication_token_doc
      {
        headers: {
          'X-Authentication-Token' => {
            description: 'user authentication token', required: true
          }
        }
      }
    end
  end
end
