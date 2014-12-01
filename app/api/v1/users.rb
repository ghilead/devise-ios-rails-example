module V1
  class Users < Grape::API
    desc 'User Sign up'
    params do
      requires :email, type: String, desc: 'user email'
      requires :password, type: String, desc: 'user password'
    end
    post '/', serializer: V1::UserSerializer do
      V1::LoginService.new(snake_declared_params, self).call
    end
  end
end
