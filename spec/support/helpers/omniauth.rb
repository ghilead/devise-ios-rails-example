OmniAuth.config.test_mode = true
module OmniAuth
  module Mock
    def self.valid_google_auth
      OmniAuth.config.mock_auth[:google_oauth2] = {
        'provider' => 'google_oauth2',
        'uid' => '123545',
        'info' => {
          'email' => 'mockuser@netguru.co'
        },
      }
    end

    def self.invalid_google_auth
      OmniAuth.config.mock_auth[:google_oauth2] = {
        'provider' => 'google_oauth2',
        'uid' => '123545',
        'info' => {
          'email' => 'justin@bieber.co'
        },
      }
    end
  end

  module SessionHelpers
    def signin
      auth_google_mock
      visit sign_in_path
    end
  end
end
