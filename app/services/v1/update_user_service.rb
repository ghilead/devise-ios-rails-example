module V1
  class UpdateUserService
    attr_reader :user, :params

    def initialize(user, params)
      @user = user
      @params = params
    end

    def call
      return if @user.nil?
      @user.update_attributes! Hash(params)
      @user
    end
  end
end
