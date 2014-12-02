module V1
  class RequestPasswordReset < Grape::API
    desc 'Request a password reset'
    params do
      requires :email, type: String, desc: 'user email'
    end
    post '/requestPasswordReset' do
      status 204
      V1::RequestPasswordResetService.new(snake_declared_params, self).call
    end
  end
end
