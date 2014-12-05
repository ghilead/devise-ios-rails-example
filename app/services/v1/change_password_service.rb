module V1
  class ChangePasswordService
    attr_reader :params, :current_user, :user_to_change_password
    def initialize(current_user, params)
      @params = Hash(params)
      @current_user = current_user
      @user_to_change_password = User.find(@params[:id])
    end

    def call!
      return if current_user.nil?
      raise(ForbiddenError) if current_user != user_to_change_password
      user_to_change_password.attributes = params
      user_to_change_password.save!
      user_to_change_password
    end

    private

    def password_match?
      params[:password] == params[:password_confirmation]
    end
  end
end
