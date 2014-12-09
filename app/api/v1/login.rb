module V1
  class Login < Grape::API
    desc 'User login'
    params do
      requires :user, type: Hash do
        requires :email, type: String, desc: 'user email'
        requires :password, type: String, desc: 'user password'
      end
    end
    post '/users/sign_in', serializer: V1::UserSerializer do
      status 200
      V1::LoginService.new(snake_declared_params[:user]).call!
    end

    desc 'User login (not recommended)'
    params do
      requires :user, type: Hash do
        requires :email, type: String, desc: 'user email'
        requires :password, type: String, desc: 'user password'
      end
    end
    get '/users/sign_in', serializer: V1::UserSerializer do
      V1::LoginService.new(snake_declared_params[:user]).call!
    end
  end
end
