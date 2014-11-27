module V1
  class Login < Grape::API
    desc 'User login'
    params do
      requires :username, type: String, desc: 'user username'
      requires :password, type: String, desc: 'user password'
    end
    get '/login' do
    end
  end
end
