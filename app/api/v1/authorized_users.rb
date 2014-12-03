module V1
  class AuthorizedUsers < Grape::API
    resources :users do
      before { authorize! }

      desc 'Update User'
      params do
        optional :email, type: String, desc: 'user email'
      end
      put '/', serializer: V1::UserSerializer do
        V1::UpdateUserService.new(current_user, snake_declared_params, self).call
      end
    end
  end
end
