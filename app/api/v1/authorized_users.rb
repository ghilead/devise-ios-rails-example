module V1
  class AuthorizedUsers < Grape::API
    before { authorize! }

    resources :users do
      desc 'Update User', require_authentication_token_doc
      params do
        requires :id, type: Integer, desc: 'user id'
        optional :email, type: String, desc: 'user email'
      end
      put ':id', serializer: V1::UserSerializer do
        V1::UpdateUserService.new(current_user, snake_declared_params).call
      end

      desc 'Delete Own Account', require_authentication_token_doc
      params do
        requires :id, type: Integer, desc: 'user id'
      end
      delete ':id', serializer: V1::UserSerializer do
        V1::DeleteOwnAccountService.new(current_user, snake_declared_params).call
      end

      desc 'Change User password', require_authentication_token_doc
      params do
        requires :id, type: Integer, desc: 'user id'
        requires :password, type: String, desc: 'new password'
        requires :passwordConfirmation, type: String, desc: 'repeated new password'
      end
      put ':id/password', serializer: V1::UserSerializer do
        V1::ChangePasswordService.new(current_user, snake_declared_params).call
      end
    end
  end
end
