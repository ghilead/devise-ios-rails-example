module V1
  class Login < Grape::API
    desc 'User login'
    params do
      requires :email, type: String, desc: 'user email'
      requires :password, type: String, desc: 'user password'
    end
    post '/login', serializer: V1::UserSerializer do
      status 200
      V1::LoginService.new(snake_declared_params).call!
    end

    desc 'User login (not recommended)'
    params do
      requires :email, type: String, desc: 'user email'
      requires :password, type: String, desc: 'user password'
    end
    get '/login', serializer: V1::UserSerializer do
      V1::LoginService.new(snake_declared_params).call!
    end
  end
end
