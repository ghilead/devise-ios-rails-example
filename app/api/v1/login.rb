module V1
  class Login < Grape::API
    desc 'User login'
    params do
      requires :username, type: String, desc: 'user username'
      requires :password, type: String, desc: 'user password'
    end
    get '/login', serializer: V1::UserSerializer do
      user = User.find_by_username(snake_declared_params[:username])
      if user.present? && user.valid_password?(snake_declared_params[:password])
        user
      else
        error!('unauthorized', 401)
      end
    end
  end
end
