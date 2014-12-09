module V1
  class AuthorizedUsers < Grape::API
    before { authorize! }

    resources :users do
      desc 'Update User', require_authentication_token_doc
      params do
        optional :email, type: String, desc: 'user email'
      end
      put '/', serializer: V1::UserSerializer do
        V1::UpdateUserService.new(current_user, snake_declared_params).call!
      end

      desc 'Delete Own Account', require_authentication_token_doc
      delete '/', serializer: V1::UserSerializer do
        V1::DeleteOwnAccountService.new(current_user, snake_declared_params).call!
      end

      desc 'Change User password', require_authentication_token_doc
      params do
        requires :password, type: String, desc: 'new password'
        requires :passwordConfirmation, type: String, desc: 'repeated new password'
      end
      put '/password', serializer: V1::UserSerializer do
        V1::ChangePasswordService.new(current_user, snake_declared_params).call!
      end
    end
  end
end
