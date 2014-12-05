module V1
  class DeleteOwnAccountService
    attr_reader :current_user, :user_to_delete, :params

    def initialize(current_user, params)
      @current_user = current_user
      @user_to_delete = User.find(params[:id])
    end

    def call!
      return if current_user.nil?
      raise(ForbiddenError) if current_user != user_to_delete
      user_to_delete.destroy!
    end
  end
end
