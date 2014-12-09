module V1
  class UnauthorizedUsers < Grape::API
    resources :users do
      desc 'User Sign up'
      params do
        requires :user, type: Hash do
          requires :email, type: String, desc: 'user email'
          requires :password, type: String, desc: 'user password'
        end
      end
      post '/', serializer: V1::UserSerializer do
        V1::RegisterService.new(snake_declared_params[:user]).call!
      end
    end
  end
end
