module V1
  class UpdateUserService
    attr_reader :current_user, :user_to_update, :params

    def initialize(user, params)
      @params = Hash(params)
      @current_user = user
      @user_to_update = User.find(@params[:id])
    end

    def call
      return if current_user.nil?
      raise(ForbiddenError) if current_user != user_to_update
      user_to_update.update_attributes! Hash(params)
      user_to_update
    end
  end
end
