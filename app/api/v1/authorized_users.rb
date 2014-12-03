module V1
  class AuthorizedUsers < Grape::API
    before { authorize! }

    resources :users do

      desc 'Update User'
      params do
        optional :email, type: String, desc: 'user email'
      end
      put '/', serializer: V1::UserSerializer do
        V1::UpdateUserService.new(current_user, snake_declared_params).call
      end

      desc 'Delete Own Account'
      delete '/', serializer: V1::UserSerializer do
        V1::DeleteOwnAccountService.new(current_user).call
      end
    end
  end
end
