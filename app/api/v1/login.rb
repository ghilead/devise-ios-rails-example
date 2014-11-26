module V1
  class Login < Grape::API
    params do
      requires :username, type: String, desc: 'user email'
      requires :password, type: String, desc: 'user password'
    end
    desc 'User login'
    get '/login' do
    end
  end
end
