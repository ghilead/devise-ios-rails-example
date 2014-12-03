module V1
  class UpdateUserService
    attr_reader :user, :params, :context

    def initialize(user, params, context)
      @user = user
      @params = params
      @context = context
    end

    def call
      return if @user.nil?
      @user.update_attributes! Hash(params)
      @user
    end
  end
end
