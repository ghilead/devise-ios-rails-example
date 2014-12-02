module V1
  class RequestPasswordResetService
    attr_reader :params, :user, :context

    def initialize(params, context)
      @params = params
      @context = context
      @user = User.find_by_email!(@params[:email])
    end

    def call
      user.send_reset_password_instructions
    end
  end
end
