module V1
  class RegisterService
    attr_reader :params, :user, :context

    def initialize(params, context)
      @params = params
      @context = context
      @user = User.new(@params)
    end

    def call
      @user.save!
      @user
    end
  end
end
