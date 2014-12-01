module V1
  class Login < Grape::API
    desc 'User login'
    params do
      requires :username, type: String, desc: 'user username'
      requires :password, type: String, desc: 'user password'
    end
    post '/login', serializer: V1::UserSerializer do
      V1::LoginService.new(snake_declared_params, self).call
    end

    desc 'User login (not recommended)'
    params do
      requires :username, type: String, desc: 'user username'
      requires :password, type: String, desc: 'user password'
    end
    get '/login', serializer: V1::UserSerializer do
      V1::LoginService.new(snake_declared_params, self).call
    end
  end
end
