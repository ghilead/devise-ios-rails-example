module V1
  class RequestPasswordReset < Grape::API
    desc 'Request a password reset'
    params do
      requires :user, type: Hash do
        requires :email, type: String, desc: 'user email'
      end
    end
    post '/users/password' do
      status 204
      V1::RequestPasswordResetService.new(snake_declared_params[:user]).call!
    end
  end
end
