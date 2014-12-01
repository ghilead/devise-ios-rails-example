module V1
  class LoginService
    attr_reader :params, :user, :context

    def initialize(params, context)
      @params = params
      @context = context
      @user = User.find_by_username(@params[:username])
    end

    def call
      if authenticated?
        user
      else
        context.error!(error, 401)
      end
    end

    private

    def authenticated?
      user.present? && user.valid_password?(params[:password])
    end

    def error
      Error.new(
        message: 'unauthorized',
        status: 401,
        code: 0
      )
    end
  end
end
